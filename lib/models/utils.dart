// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

String SERVER_URL = 'https://api.esmconsulting.es/semicyuc/';
String CATEGORY_ENDPOINT = 'categorias';
String TOPIC_ENDPOINT = 'topicos';
String NOTIFICATION_ENDPOINT = 'notificaciones';
String SUSCRIPTION_ENDPOINT = 'suscripciones';
String LOGIN_ENDPOINT = 'login';
String MESSAGE_ENDPOINT = 'mensajes';
String LOGOUT_ENDPINT = 'logout';
String USER_ENDPOINT = 'usuario';

Color OragneColor = const Color.fromRGBO(228, 131, 80, 1.0);
Color darkBlue = const Color.fromRGBO(0, 101, 170, 1.0);
Color midBlue = const Color.fromRGBO(200, 237, 255, 1.0);
Color lightBlue = const Color.fromRGBO(248, 254, 255, 1.0);
Color grey = const Color.fromRGBO(126, 136, 144, 1.0);
