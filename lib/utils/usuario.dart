import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:semicyuc2/models/utils.dart';

import '../models/http_exception.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user {
    return _user;
  }

  bool _loaded = false;

  bool get loaded {
    return _loaded;
  }

  Future<void> fetchUser(String token) async {
    final url = Uri.parse(
      SERVER_URL + USER_ENDPOINT,
    );
    try {
      final response = await http.get(
        url,
        headers: {"Token": token},
      );
      final _extractedData = json.decode(response.body);
      if (_extractedData['status'] == 'error') {
        var error = HttpException(_extractedData['result']['error_msg'],
            int.parse(_extractedData['result']['error_id']));
        // print(error);
        throw error;
      }
      _user = User(
        int.parse(_extractedData['result']['idusuario']),
        _extractedData['result']['usuario'],
        _extractedData['result']['nombre'],
        _extractedData['result']['apellido'],
        DateTime.parse(_extractedData['result']['fechaalta']),
      );
      _loaded = true;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

class User with ChangeNotifier {
  final int id;
  final String username;
  final String name;
  final String lastname;
  late DateTime registrationDate;

  User(
    this.id,
    this.username,
    this.name,
    this.lastname,
    this.registrationDate,
  );
}
