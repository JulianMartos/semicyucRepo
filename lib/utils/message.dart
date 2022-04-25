import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semicyuc2/models/utils.dart';

import '../models/http_exception.dart';

class Message {
  final int _id;
  final String _title;
  final String _text;
  final DateTime _date;
  final int _topicId;
  final String _sender;
  final String _nombreTopico;
  final _file;

  Message(
    this._id,
    this._title,
    this._text,
    this._date,
    this._topicId,
    this._sender,
    this._nombreTopico,
    this._file,
  );

  int get id => _id;
  String get title => _title;
  String get text => _text;
  DateTime get date => _date;
  int get topicId => _topicId;
  String get sender => _sender;
  String get nombreTopico => _nombreTopico;
  String? get file => _file;

  static List<Message> toList(List<dynamic> jsonDecoded) {
    List<Message> lista = [];
    for (var element in jsonDecoded) {
      lista.add(
        Message(
          int.parse(element['idmensaje']),
          element['asunto'],
          element['cuerpo'],
          DateTime.parse(element['fecha']),
          int.parse(element['idtopico']),
          element['nombre'] + ' ' + element['apellido'],
          element['nombretopico'],
          (element['archivo'] != null) ? element['archivo'] : null,
        ),
      );
    }
    return lista;
  }
}

class MessageProvider with ChangeNotifier {
  List<Message> _messageList = [];

  List<Message> get messageList => _messageList;

  Message getMessageById(int id) {
    return _messageList.firstWhere((message) => message._id == id);
  }

  Future<void> getMessages(String token) async {
    final url = Uri.parse(
      SERVER_URL + MESSAGE_ENDPOINT,
    );
    try {
      final response = await http.get(
        url,
        headers: {"Token": token},
      );

      final responseData = json.decode(response.body);
      if (responseData['status'] == 'error') {
        var error = HttpException(responseData['result']['error_msg'],
            int.parse(responseData['result']['error_id']));
        throw error;
      }
      if (responseData['result'] != null) {
        _messageList = Message.toList(responseData['result']);
      } else {
        _messageList = [];
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
