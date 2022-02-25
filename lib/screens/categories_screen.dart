import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../utils/auth.dart';

class CartegoriesScreen extends StatelessWidget {
  const CartegoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Provider.of<Auth>(context, listen: false).token ??
                'Not Logged In'),
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
