import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/categories_screen.dart';

import './utils/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
          ),
          home: auth.isAuth
              ? CartegoriesScreen()
              : FutureBuilder(
                  future: auth.isLoggedIn(),
                  builder: (ctx, authResul) =>
                      (authResul.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
                ),
        ),
      ),
    );
  }
}
