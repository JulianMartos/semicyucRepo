import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../utils/message.dart';
import './../icons/app_icons.dart';
import './../screens/general_screen.dart';
import './../services/local_notification_service.dart';
import './../utils/auth.dart';
import './../widgets/message_list.dart';
import './../widgets/index.dart';
import './../widgets/private_area.dart';
import './../widgets/message.dart';
import './../models/utils.dart';

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
    LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitCubeGrid(
            color: Color.fromRGBO(243, 1, 0, 1.0),
            size: 50.0,
          ),
        ),
        child: MessageList()),
    // Buscar(),
  ];

  int _selectedPageIdx = 1;

  void _selectPage(int idx) {
    setState(() {
      _selectedPageIdx = idx;
    });
  }

  Future<void> requestPermision() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    print(await messaging.getToken());

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
                icon: const Icon(Icons.logout),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
          bottom: const PreferredSize(
            child: Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            preferredSize: Size.fromHeight(10),
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
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    icon: FaIcon(FontAwesomeIcons.lightUser),
                    text: 'Area Privada',
                  ),
                  Tab(
                    icon: Icon(
                      AppIcons.svgviewer_output,
                      color: Colors.white,
                    ),
                    text: 'Home',
                  ),
                  Tab(
                    icon: FaIcon(FontAwesomeIcons.lightEnvelope),
                    text: 'Mensajes',
                  ),
                ],
              ),
            ),
            Container(
              height:
                  Theme.of(context).platform == TargetPlatform.iOS ? 40 : 25,
              width: double.infinity,
              alignment: Theme.of(context).platform == TargetPlatform.iOS
                  ? Alignment.topCenter
                  : Alignment.center,
              child: const AutoSizeText(
                "Desarrollado por ESM Consulting",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    OragneColor,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
