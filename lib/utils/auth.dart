import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './../models/http_exception.dart';

import './../models/utils.dart';

// import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late String? _username;
  bool _loggedIn = false;

  bool get isAuth {
    return _loggedIn;
  }

  String get token {
    return _token;
  }

  String? get username {
    return _username;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('Token')) {
      _token = prefs.getString('Token').toString();
      _loggedIn = true;
      notifyListeners();
      return true;
    } else {
      return true;
    }
  }

  Future<void> logout() async {
    _token = "";
    _loggedIn = false;
    _username = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final url = Uri.parse(SERVER_URL + LOGIN_ENDPOINT);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'usuario': username, 'password': password},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'error') {
        var error = HttpException(responseData['result']['error_msg'],
            int.parse(responseData['result']['error_id']));
        // print(error);
        throw error;
      }
      _token = responseData['result']['token'];
      _username = username;
      _loggedIn = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('Token', _token.toString());
    } catch (error) {
      rethrow;
    }
  }
}
