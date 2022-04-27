import 'package:flutter/material.dart';

import '../models/utils.dart';

class Voting extends StatelessWidget {
  const Voting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No hay votaciones disponibles."),
    );
  }
}
