import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/utils.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
          child: Text(
            "Datos Personales".toUpperCase(),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
              bottom: 10,
            ),
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
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nombre', style: labelBold),
                        Text('Jose Maria', style: labelRegular),
                      ],
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Primer Apellido', style: labelBold),
                        Text('Suárez', style: labelRegular),
                      ],
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Segundo Apellido', style: labelBold),
                        Text('López', style: labelRegular),
                      ],
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefono de Contacto', style: labelBold),
                        Text('649-949-923', style: labelRegular),
                      ],
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefono particular: ', style: labelBold),
                        Text('649-342-123', style: labelRegular),
                      ],
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ', style: labelBold),
                        Text('jmaria@hotmail.com', style: labelRegular),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: Image.network(
                          'https://area-privada.semicyuc.org/img/persona-generico.png',
                          fit: BoxFit.fill,
                        ),
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
