import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './models/utils.dart';

import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/main_screen.dart';
import './screens/general_screen.dart';

import './utils/auth.dart';
import './utils/categories.dart';
import './utils/message.dart';
import './utils/topics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ChangeNotifierProvider(
        create: (ctx) => Auth(),
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MultiProvider(
            providers: [
              ChangeNotifierProvider<Topics>.value(
                value: Topics(),
              ),
              ChangeNotifierProvider<MessageProvider>.value(
                value: MessageProvider(),
              )
            ],
            child: MaterialApp(
                title: 'Semi',
                theme: ThemeData(
                  fontFamily: 'Lato',
                  primarySwatch: generateMaterialColor(
                      const Color.fromRGBO(126, 136, 144, 1.0)),
                  primaryColor: const Color.fromRGBO(243, 1, 0, 1.0),
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    bodyText2: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.w500,
                    ),
                    headline3: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(228, 131, 80, 1.0),
                    ),
                    headline4: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(228, 131, 80, 1.0),
                    ),
                    headline5: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(243, 1, 0, 1.0),
                    ),
                  ),
                ),
                routes: {
                  AuthScreen.routeName: (context) => const AuthScreen(),
                  GeneralScreen.routeName: (context) => const GeneralScreen(),
                  MainScreen.routeName: (context) => const MainScreen(),
                  SplashScreen.routeName: (context) => const SplashScreen(),
                },
                home: auth.isAuth
                    ? const MainScreen()
                    : FutureBuilder(
                        future: auth.isLoggedIn(),
                        builder: (ctx, authResul) =>
                            authResul.connectionState == ConnectionState.waiting
                                ? const SplashScreen()
                                : const AuthScreen(),
                      )),
          ),
        ),
      ),
    );
  }
}
