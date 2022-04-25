import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import './../models/utils.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                'Los Profesionales Del Enfermo Crítico'.toUpperCase(),
                // style: TextStyle(
                //   fontSize: 25,
                //   fontWeight: FontWeight.bold,
                //   color: Theme.of(context).primaryColor,
                // ),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "La Sociedad Española de Medicina Intensiva, Crítica y Unidades Coronarias (SEMICYUC) fue creada en 1971 como asociación científica, multidisciplinaria y de carácter educativo. Está formada principalmente por médicos especialistas en Medicina Intensiva, con la misión de promover la mejora en la atención al paciente críticamente enfermo.",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                    color: grey,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
