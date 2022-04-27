import 'package:SEMICYUC/screens/general_screen_with_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/general_screen.dart';

class PrivateAreaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget widget;
  final String title;

  const PrivateAreaButton(this.icon, this.text, this.widget, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          GeneralScreenWithTitle.routeName,
          arguments: {
            "widget": widget,
            "title": title,
          },
        );
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FaIcon(
                    icon,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      text,
                      textScaleFactor: 1.0,
                      maxLines: 4,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              ),
            ],
          )),
    );
  }
}
