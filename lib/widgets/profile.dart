import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/utils/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: Provider.of<Auth>(context).logout,
            child: const Text("logout")));
  }
}
