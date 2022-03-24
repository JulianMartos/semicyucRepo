import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/http_exception.dart';
import './../utils/message.dart';
import './../screens/general_screen.dart';
import './../utils/auth.dart';
import './../widgets/message.dart';

class MessageList extends StatefulWidget {
  MessageList({Key? key}) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final sdivider = const Divider(
    height: 10,
    thickness: 2,
    indent: 20,
    endIndent: 20,
    color: Colors.grey,
  );

  bool _loading = false;

  @override
  void initState() {
    context.loaderOverlay.show();
    _loading = true;
    try {
      _refreshMessages().then((value) {
        context.loaderOverlay.hide();
        _loading = false;
      });
    } on HttpException catch (error) {
      context.loaderOverlay.hide();
      _showErrorDialog(error);
    }
    super.initState();
  }

  void _showErrorDialog(HttpException error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ha ocurrido un error'),
        content: Text(error.toString()),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              if (error.statusCode == 401) {
                Provider.of<Auth>(context, listen: false).logout();
              }
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _refreshMessages() async {
    try {
      await Provider.of<MessageProvider>(context, listen: false)
          .getMessages(Provider.of<Auth>(context, listen: false).token);
    } on HttpException catch (error) {
      _showErrorDialog(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _messages = Provider.of<MessageProvider>(context).messageList;
    if (!_loading) {
      context.loaderOverlay.hide();
      return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 10,
        onRefresh: _refreshMessages,
        child: _messages.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No hay mensajes en los topicos a los que esta subscrito",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: _refreshMessages,
                    child: Text("Actualizar"),
                  )
                ],
              )
            : ListView.separated(
                itemBuilder: (ctx, index) {
                  int idx = _messages.length - index - 1;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const FaIcon(FontAwesomeIcons.envelope),
                      radius: 25,
                    ),
                    title: Text(_messages[idx].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Para: ${_messages[idx].nombreTopico}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "De: ${_messages[idx].sender}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Text(_messages[idx].date.hour.toString() +
                        ':' +
                        _messages[idx].date.minute.toString()),
                    onTap: () {
                      Navigator.pushNamed(context, GeneralScreen.routeName,
                          arguments: {
                            'widget': MessageContent(_messages[idx].id),
                          });
                    },
                    // shape: Border.all(),
                  );
                },
                separatorBuilder: (ctx, idx) => sdivider,
                itemCount: _messages.length,
              ),
      );
    } else {
      return Container();
    }
  }
}
