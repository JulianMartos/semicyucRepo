import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/general_screen.dart';

class PrivateAreaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget widget;

  const PrivateAreaButton(this.icon, this.text, this.widget, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          GeneralScreen.routeName,
          arguments: {
            "widget": widget,
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
