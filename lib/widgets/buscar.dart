import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: const Text(
        'PRUEBA',
        style: TextStyle(
          fontFamily: 'Helvetica Neue',
          fontSize: 20,
          color: Color(0xff707070),
        ),
      ),
    );
  }
}
