import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import './../utils/message.dart';

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
          const SizedBox(height: 4),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
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
