import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:semicyuc2/models/utils.dart';

import '../models/http_exception.dart';

class Topics with ChangeNotifier {
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
}

class Topic with ChangeNotifier {
  final int id;
  final String title;
  final String slug;
  final int idCategory;
  late bool subscribed;
  late Color color;

  Topic(
    this.id,
    this.title,
    this.slug,
    this.idCategory,
    this.subscribed,
  ) {
    // subscribed = false;
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  Future<void> subscribe(String token) async {
    final url = Uri.parse(
      SERVER_URL + SUBSCRIPTIONS_ENDPOINT,
    );
    final _headers = {"Token": token};
    final _json = jsonEncode({"idtopico": id.toString()});
    try {
      if (!subscribed) {
        subscribed = true;
        final response = await http.post(url, headers: _headers, body: _json);
        final _extractedData = json.decode(response.body);
        if (_extractedData['status'] == 'error') {
          var error = HttpException(_extractedData['result']['error_msg'],
              int.parse(_extractedData['result']['error_id']));
          throw error;
        }
        FirebaseMessaging.instance.subscribeToTopic(slug);
        notifyListeners();
      } else {
        subscribed = false;
        final response = await http.delete(url, headers: _headers, body: _json);
        final _extractedData = json.decode(response.body);
        if (_extractedData['status'] == 'error') {
          var error = HttpException(_extractedData['result']['error_msg'],
              int.parse(_extractedData['result']['error_id']));
          throw error;
        }
        FirebaseMessaging.instance.unsubscribeFromTopic(slug);
        notifyListeners();
      }
    } catch (error) {
      subscribed = !subscribed;
      rethrow;
    }
  }

  static List<Topic> toList(List<dynamic> jsonDecoded) {
    List<Topic> lista = [];
    for (var element in jsonDecoded) {
      lista.add(Topic(
        int.parse(element['idtopico']),
        element['nombretopico'],
        element['slug'],
        int.parse(element['idcategoria']),
        element['subscrito'] == '1' ? true : false,
      ));
    }
    return lista;
  }
}
