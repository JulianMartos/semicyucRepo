import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../models/utils.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Theme.of(context).platform == TargetPlatform.iOS ? 40 : 25,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 3),
      alignment: Theme.of(context).platform == TargetPlatform.iOS
          ? Alignment.topCenter
          : Alignment.center,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "© SEMICYUC - Desarrollado por ",
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            Link(
              uri: Uri.parse('https://esmconsulting.es/'),
              target: LinkTarget.blank,
              builder: (ctx, followLink) => GestureDetector(
                onTap: followLink,
                child: const Text(
                  "ESM Consulting",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: darkBlue,
      ),
    );
  }
}
