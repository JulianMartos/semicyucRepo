import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import './../models/utils.dart';
import './../widgets/bottomBar.dart';
import './../utils/auth.dart';

class GeneralScreenWithTitle extends StatelessWidget {
  const GeneralScreenWithTitle({Key? key}) : super(key: key);
  static const routeName = '/general-screen-with-title';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final _widget = args['widget'];
    final _title = args['title'];
    final _button = args['button'];

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
              icon: const Icon(FontAwesomeIcons.signOut),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.03,
          ),
          child: const SizedBox(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10,
          // bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _title.toUpperCase(),
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: _button == null ? 10 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: lightBlue,
                  border: Border.all(
                    color: darkBlue,
                    width: 1,
                  ),
                ),
                child: _widget,
              ),
            ),
            if (_button != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _button,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
