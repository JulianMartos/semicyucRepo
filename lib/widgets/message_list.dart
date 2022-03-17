import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    Provider.of<MessageProvider>(context, listen: false)
        .getMessages(Provider.of<Auth>(context, listen: false).token)
        .then((value) {
      context.loaderOverlay.hide();
      _loading = false;
    });
    super.initState();
  }

  Future<void> _refreshMessages() =>
      //Future.delayed(const Duration(seconds: 1), () {
      Provider.of<MessageProvider>(context, listen: false)
          .getMessages(Provider.of<Auth>(context, listen: false).token);

  @override
  Widget build(BuildContext context) {
    var _messages = Provider.of<MessageProvider>(context).messageList;
    if (!_loading) {
      context.loaderOverlay.hide();
      return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 10,
        onRefresh: _refreshMessages,
        child: ListView.separated(
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
