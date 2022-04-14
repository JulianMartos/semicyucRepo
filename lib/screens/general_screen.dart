import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/widgets/bottomBar.dart';

import './../utils/auth.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({Key? key}) : super(key: key);
  static const routeName = '/general-screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final _widget = args['widget'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
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
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Provider.of<Auth>(context, listen: false).logout();
              },
              icon: const Icon(Icons.logout),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: _widget,
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
