import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../widgets/bottomBar.dart';
import './../utils/message.dart';
import './../icons/app_icons.dart';
import './../screens/general_screen.dart';
import './../services/local_notification_service.dart';
import './../utils/auth.dart';
import './../views/message_list.dart';
import './../views/index.dart';
import './../views/private_area.dart';
import './../views/message.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _CartegoriesScreenState();
}

class _CartegoriesScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const PrivateAreaWidget(),
    const IndexWidget(),
    const LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCubeGrid(
            color: Color.fromRGBO(243, 1, 0, 1.0),
            size: 50.0,
          ),
        ),
        child: MessageList()),
    // Buscar(),
  ];

  Future<void> requestPermision() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState() {
    requestPermision();
    super.initState();

    LocalNotificationService.createNotificationChannel();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null &&
          message.notification!.android != null) {
        LocalNotificationService.display(message);
      }
    });

    // FirebaseMessaging.onBackgroundMessage((message) => null)
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        final _mesageId = message.data['idMensaje'];
        await Provider.of<MessageProvider>(context, listen: false).getMessages(
          Provider.of<Auth>(context, listen: false).token,
        );

        Navigator.of(context).pushNamed(GeneralScreen.routeName, arguments: {
          'widget': MessageContent(int.parse(_mesageId)),
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if (message.notification != null) {
          final _mesageId = message.data['idMensaje'];
          await Provider.of<MessageProvider>(context, listen: false)
              .getMessages(
            Provider.of<Auth>(context, listen: false).token,
          );
          Navigator.of(context).pushNamed(GeneralScreen.routeName, arguments: {
            'widget': MessageContent(int.parse(_mesageId)),
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/headLogo.png',
            fit: BoxFit.fitWidth,
            height: 70,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 77,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: Provider.of<Auth>(context).logout,
                icon: const Icon(FontAwesomeIcons.signOut),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.03,
            ),
            child: SizedBox(),
          ),
        ),
        body: TabBarView(
          children: _pages,
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.lightUser,
                      size: 40,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      AppIcons.svgviewer_output,
                      size: 45,
                    ),
                  ),
                  Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.lightEnvelope,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
