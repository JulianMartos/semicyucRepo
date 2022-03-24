import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semicyuc2/models/utils.dart';

import '../models/http_exception.dart';

class Categories with ChangeNotifier {
  List<Categoria> _categorias = [];

  List<Categoria> get categorias {
    return [..._categorias];
  }

  Future<void> obtenerCategorias() async {
    final url = Uri.parse(
      SERVER_URL + CATEGORY_ENDPOINT,
    );
    try {
      final response = await http.get(
        url,
        headers: {"Token": "af39f07dc17af8c7358142aba02c37ad"},
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'error') {
        var error = HttpException(responseData['result']['error_msg'],
            int.parse(responseData['result']['error_id']));
        // print(error);
        throw error;
      }
      _categorias = Categoria.toList(responseData);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

class Categoria with ChangeNotifier {
  int id;
  String nombre;
  late Color color;

  Categoria(this.id, this.nombre) {
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  static List<Categoria> toList(List<dynamic> jsonDecoded) {
    List<Categoria> lista = [];
    for (var element in jsonDecoded) {
      lista.add(Categoria(
          int.parse(element['idcategoria']), element['nombrecategoria']));
    }
    return lista;
  }
}
