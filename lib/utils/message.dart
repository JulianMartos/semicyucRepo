import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Message {
  final int _id;
  final String _title;
  final String _text;
  final DateTime _date;
  final int _topicId;
  final String _sender;
  final String _nombreTopico;

  Message(
    this._id,
    this._title,
    this._text,
    this._date,
    this._topicId,
    this._sender,
    this._nombreTopico,
  );

  int get id => _id;
  String get title => _title;
  String get text => _text;
  DateTime get date => _date;
  int get topicId => _topicId;
  String get sender => _sender;
  String get nombreTopico => _nombreTopico;

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
          element['idusuario'],
          element['nombretopico'],
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
        'https://esmconsulting.es/desarrollo-api/api-flutter/mensajes');
    try {
      final response = await http.get(
        url,
        headers: {"Token": token},
      );
      print(response.body);
      print(token);
      final responseData = json.decode(response.body);
      _messageList = Message.toList(responseData);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
