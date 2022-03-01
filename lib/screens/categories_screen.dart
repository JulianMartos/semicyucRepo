import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../utils/categories.dart';
import './../utils/auth.dart';

class CartegoriesScreen extends StatefulWidget {
  const CartegoriesScreen({Key? key}) : super(key: key);

  @override
  State<CartegoriesScreen> createState() => _CartegoriesScreenState();
}

class _CartegoriesScreenState extends State<CartegoriesScreen> {
  Future<void> requestPermision() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  void initState() {
    requestPermision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var categorias = Provider.of<Categories>(context, listen: false).categorias;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Provider.of<Auth>(context, listen: false).token ??
                'Not Logged In'),
            // TextButton(
            //   onPressed: () {
            //     Provider.of<Categories>(context, listen: false)
            //         .obtenerCategorias();
            //     setState(() {});
            //   },
            //   child: Text('Actualizar'),
            // ),
            TextButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
