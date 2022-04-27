import 'package:flutter/material.dart';

import '../models/utils.dart';

class Voting extends StatelessWidget {
  const Voting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10,
            bottom: 10,
          ),
          child: Text(
            "Votaciones".toUpperCase(),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: lightBlue,
              border: Border.all(
                color: darkBlue,
                width: 1,
              ),
            ),
            child: const Center(
              child: Text("No hay votaciones disponibles."),
            ),
          ),
        ),
      ],
    );
  }
}
