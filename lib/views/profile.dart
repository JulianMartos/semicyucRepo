import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/utils.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  TextStyle style = const TextStyle(
    fontSize: 15,
  );
  TextStyle styleBold =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Datos Personales",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: lightBlue,
              border: Border.all(
                color: darkBlue,
                width: 1,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Nombre: ', style: styleBold),
                      // Text('Nombre', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Primer Apellido: ', style: styleBold),
                      // Text('Apellido 1', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Segundo Apellido: ', style: styleBold),
                      // Text('Apellido 2', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Telefono de Contacto: ', style: styleBold),
                      // Text('999 999 9999', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Telefono particular: ', style: styleBold),
                      // Text('999 999 9999', style: style),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text('No. Socio: ', style: styleBold),
                  //     Text('9999', style: style),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text('Email: ', style: styleBold),
                      // Text('usuario@semicyuc.es', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Nacionalidad: ', style: styleBold),
                      // Text('Hospital Central General', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Sexo: ', style: styleBold),
                      // Text('No Definido', style: style),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: lightBlue,
                      border: Border.all(
                        color: darkBlue,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 100),
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FaIcon(
                        FontAwesomeIcons.lightUserCircle,
                        size: 200,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
