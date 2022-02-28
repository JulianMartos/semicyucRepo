import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:semicyuc2/utils/categories.dart';
import './../utils/auth.dart';

class CartegoriesScreen extends StatefulWidget {
  const CartegoriesScreen({Key? key}) : super(key: key);

  @override
  State<CartegoriesScreen> createState() => _CartegoriesScreenState();
}

class _CartegoriesScreenState extends State<CartegoriesScreen> {
  bool _isInit = true;

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
  void setState(VoidCallback fn) {
    Provider.of<Categories>(context, listen: false).obtenerCategorias();
    super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      print("Change Dep $_isInit");
      Provider.of<Categories>(context).obtenerCategorias();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _categoriesData = Provider.of<Categories>(context);
    final _categorias = _categoriesData.categorias;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Provider.of<Auth>(context, listen: false).token ??
                'Not Logged In'),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: _categorias.length,
                itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
                  value: _categorias[idx],
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      // tileColor: Colors.blue,
                      // contentPadding: EdgeInsets.all(20),
                      minVerticalPadding: 10,
                      title: Text("Id: " + _categorias[idx].id.toString()),
                      subtitle: Text(_categorias[idx].nombre),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => setState(() {}),
              child: Text('Actualizar'),
            ),
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
