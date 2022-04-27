import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import './../models/utils.dart';
import './../models/http_exception.dart';
import './../models/topic.dart';

class SuscriptionTopics with ChangeNotifier {
  late List<Topic> _topics = [];

  List<Topic> get topics {
    return [..._topics];
  }

  final List<int> _topicsToAdd = [];

  final List<int> _topicsToRemove = [];

  void addTopic(int id) {
    if (_topicsToRemove.contains(id)) {
      _topicsToRemove.remove(id);
    } else {
      _topicsToAdd.add(id);
    }
  }

  void removeTopic(int id) {
    if (_topicsToAdd.contains(id)) {
      _topicsToAdd.remove(id);
    } else {
      _topicsToRemove.add(id);
    }
  }

  List<int> get topicsToAdd {
    return [..._topicsToAdd];
  }

  List<int> get topicsToRemove {
    return [..._topicsToRemove];
  }

  Future<void> fetchGtTopic(int idCategory, String token) async {
    final url = Uri.parse(
      SERVER_URL + SUSCRIPTION_ENDPOINT + '?idcategoria=$idCategory',
    );
    try {
      final response = await http.get(
        url,
        headers: {"Token": token},
      );
      final _extractedData = json.decode(response.body);

      if (_extractedData != null) {
        _topics = Topic.toList(_extractedData);
      } else {
        _topics = [];
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> saveTopics(String token) async {
    final url = Uri.parse(SERVER_URL + SUSCRIPTION_ENDPOINT);
    try {
      final response = await http.put(
        url,
        headers: {"Token": token},
        body: json.encode({
          "idsuscripciones": _topicsToAdd,
          "idsuscripcionesEliminar": _topicsToRemove,
        }),
      );
      final _extractedData = json.decode(response.body);
      if (_extractedData['status'] == 'error') {
        var error = HttpException(_extractedData['result']['error_msg'],
            int.parse(_extractedData['result']['error_id']));
        throw error;
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
