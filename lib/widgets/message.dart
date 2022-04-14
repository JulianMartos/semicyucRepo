import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/link.dart';

import './../utils/message.dart';
import './../models/utils.dart';

class MessageContent extends StatelessWidget {
  final int id;

  const MessageContent(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_US', null);
    final _message =
        Provider.of<MessageProvider>(context, listen: false).getMessageById(id);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMMd('es_US').format(_message.date),
              ),
              Text(
                DateFormat.jm().format(_message.date),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "De: ${_message.sender}",
          ),
          Text(
            "Para: ${_message.nombreTopico}",
          ),
          const SizedBox(height: 8),
          Text("Asunto: ${_message.title}"),
          if (_message.file != null)
            Link(
              target: LinkTarget.self,
              uri: Uri.parse(
                  "http://api.esmconsulting.es/uploads/" + _message.file!),
              builder: (ctx, followLink) => TextButton(
                onPressed: followLink,
                child: FittedBox(
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.lightPaperclip,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        _message.file!,
                        style: TextStyle(
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 4),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                  child: Html(
                data: _message.text,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
