import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Categories with ChangeNotifier {
  List<Categoria> _categorias = [];

  List<Categoria> get categorias {
    return [..._categorias];
  }

  Future<void> obtenerCategorias() async {
    print("Entre 1");
    final url = Uri.parse(
        'https://esmconsulting.es/desarrollo-api/api-flutter/categorias?page=1');
    try {
      final response = await http.get(
        url,
        headers: {"Token": "af39f07dc17af8c7358142aba02c37ad"},
      );
      final responseData = json.decode(response.body);
      // if (responseData['status'] == 'error') {
      //   print("aaaa");
      //   String error = responseData['result']['error_msg'];
      //   throw (error);
      // }
      _categorias = Categoria.toList(responseData);

      print(_categorias);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

class Categoria with ChangeNotifier {
  int id;
  String nombre;

  Categoria(this.id, this.nombre);

  static List<Categoria> toList(List<dynamic> jsonDecoded) {
    List<Categoria> lista = [];
    jsonDecoded.forEach((element) {
      lista.add(Categoria(
          int.parse(element['idcategoria']), element['nombrecategoria']));
    });
    return lista;
  }
}
