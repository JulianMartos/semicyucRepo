import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/auth.dart';
import './../models/http_exception.dart';
import './../utils/topics.dart';

class TopicTile extends StatefulWidget {
  final Topic topic;
  const TopicTile(this.topic, {Key? key}) : super(key: key);

  @override
  State<TopicTile> createState() => _TopicTileState();
}

class _TopicTileState extends State<TopicTile> {
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ha ocurrido un error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      activeColor: Theme.of(context).primaryColor,
      title: Text(
        widget.topic.title,
        style: Theme.of(context).textTheme.headline5,
      ),
      value: widget.topic.subscribed,
      onChanged: (value) async {
        try {
          setState(() {
            Provider.of<Topic>(context, listen: false).subscribe(
              Provider.of<Auth>(context, listen: false).token,
            );
          });
        } on HttpException catch (error) {
          _showErrorDialog(error.toString());
        }
      },
    );
  }
}
