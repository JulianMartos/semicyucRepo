import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './../models/utils.dart';

import '../models/http_exception.dart';
import '../models/topic.dart';

class NotificationsTopics with ChangeNotifier {
  late List<Topic> _topics = [];

  List<Topic> get topics {
    return [..._topics];
  }

  Future<void> fetchTopics(int idCategory, String token) async {
    final url = Uri.parse(
      SERVER_URL + TOPIC_ENDPOINT + '?idcategoria=$idCategory',
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
      if (_extractedData['result'] != null) {
        _topics = Topic.toList(_extractedData['result']);
      } else {
        _topics = [];
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> saveTopics(
      List<int> registrar, List<int> borrar, String token) async {
    final url = Uri.parse(SERVER_URL + SUSCRIPTION_ENDPOINT);
    try {
      final response = await http.put(
        url,
        headers: {"Token": token},
        body: json.encode({
          "idsuscripciones": registrar,
          "idsuscripcionesEliminar": borrar,
        }),
      );
      final _extractedData = json.decode(response.body);
      if (_extractedData['status'] == 'error') {
        var error = HttpException(_extractedData['result']['error_msg'],
            int.parse(_extractedData['result']['error_id']));
        // print(error);
        throw error;
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
