import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/utils/auth.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Provider.of<Auth>(context).token),
    );
  }
}
