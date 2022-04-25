import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/utils/suscriptionTopics.dart';
import 'package:semicyuc2/utils/usuario.dart';

import './models/utils.dart';

import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/main_screen.dart';
import './screens/general_screen.dart';

import './utils/auth.dart';
import './utils/message.dart';
import 'utils/notificationTopics.dart';

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
              ChangeNotifierProvider<NotificationsTopics>.value(
                value: NotificationsTopics(),
              ),
              ChangeNotifierProvider<NotificationsTopics>.value(
                value: NotificationsTopics(),
              ),
              ChangeNotifierProvider<SuscriptionTopics>.value(
                value: SuscriptionTopics(),
              ),
              ChangeNotifierProvider<MessageProvider>.value(
                value: MessageProvider(),
              ),
              ChangeNotifierProvider<UserProvider>.value(
                value: UserProvider(),
              ),
            ],
            child: MaterialApp(
                title: 'Semi',
                theme: ThemeData(
                    backgroundColor: Colors.white,
                    scaffoldBackgroundColor: Colors.white,
                    fontFamily: 'Monserrat',
                    primarySwatch: generateMaterialColor(
                        const Color.fromRGBO(126, 136, 144, 1.0)),
                    primaryColor: const Color.fromRGBO(243, 1, 0, 1.0),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 15,
                        color: grey,
                      ),
                      bodyText2: TextStyle(
                        fontSize: 15,
                        color: darkBlue,
                      ),
                      headline3: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: darkBlue,
                      ),
                      headline4: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkBlue,
                      ),
                      headline5: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: darkBlue,
                      ),
                    ),
                    dividerColor: darkBlue),
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
