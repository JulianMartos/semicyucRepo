import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../screens/general_screen.dart';
import '../utils/auth.dart';
import '../utils/topics.dart';

import './topics_list.dart';

class PrivateAreaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget widget;
  final int idCategory;

  const PrivateAreaButton(this.icon, this.text, this.widget, this.idCategory,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.loaderOverlay.show();
        Provider.of<Topics>(context, listen: false)
            .fetchTopics(
              idCategory,
              Provider.of<Auth>(context, listen: false).token,
            )
            .then(
              (_) => {
                context.loaderOverlay.hide(),
                Navigator.pushNamed(
                  context,
                  GeneralScreen.routeName,
                  arguments: {
                    "widget": widget,
                  },
                )
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
                    padding: const EdgeInsets.all(5.0),
                    child: AutoSizeText(
                      text,
                      maxLines: 4,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    )),
              ),
            ],
          )),
    );
  }
}
