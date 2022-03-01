import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/categories_screen.dart';

import './utils/auth.dart';
import './utils/categories.dart';

import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCenter.startAsync(
    appSecretAndroid: '49361c2e-b788-4bc2-a33d-838b04b3e06b',
    appSecretIOS: '6520de7f-6b1f-42ca-be79-18cf36f6480a',
    enableDistribute: false,
  );
  await AppCenter.configureDistributeDebugAsync(enabled: false);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Categories(),
          )
        ],
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
          ),
          home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) =>
                Consumer<Auth>(builder: (ctx, auth, _) {
              if (snapshot.hasError) {
                return AuthScreen();
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return auth.isAuth
                    ? CartegoriesScreen()
                    : FutureBuilder(
                        future: auth.isLoggedIn(),
                        builder: (ctx, authResul) =>
                            (authResul.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen()));
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return SplashScreen();
            }),
          ),
        ));
  }
}
