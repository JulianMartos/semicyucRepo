import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import './../models/utils.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       const Color.fromRGBO(126, 136, 144, 1.0),
      //       const Color.fromRGBO(243, 1, 0, 1.0),
      //     ],
      //   ),
      // ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                'Sociedad Española de Medicina Intensiva, Crítica y Unidades Coronarias'
                    .toUpperCase(),
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Text(
                "Creada en 1971 como asociación científica, multidisciplinaria y de carácter educativo. Está formada principalmente por médicos especialistas en Medicina Intensiva, con la misión de promover la mejora en la atención al paciente críticamente enfermo.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.2,
                  color: grey,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Link(
                    uri: Uri.parse('https://semicyuc.org/'),
                    target: LinkTarget.blank,
                    builder: (ctx, followLink) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        shape: const StadiumBorder(),
                        fixedSize: const Size(250, 35),
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: followLink,
                      child: Text(
                        "Visita nuestra web".toUpperCase(),
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Link(
                    uri: Uri.parse('https://semicyuc.org/noticias/'),
                    target: LinkTarget.blank,
                    builder: (ctx, followLink) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        shape: const StadiumBorder(),
                        fixedSize: const Size(250, 35),
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: followLink,
                      child: Text(
                        "Noticias".toUpperCase(),
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Link(
                    uri: Uri.parse('https://pagos.semicyuc.net/'),
                    target: LinkTarget.blank,
                    builder: (ctx, followLink) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        primary: Theme.of(context).primaryColor,
                        shape: const StadiumBorder(),
                        fixedSize: const Size(250, 35),
                      ),
                      onPressed: followLink,
                      child: Text(
                        "Visita nuestra tienda".toUpperCase(),
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
