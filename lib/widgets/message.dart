import 'package:flutter/material.dart';
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
          const SizedBox(height: 10),
          Text(
            "De: ${_message.sender}",
          ),
          Text(
            "Para: ${_message.nombreTopico}",
          ),
          const SizedBox(height: 20),
          Text("Asunto: ${_message.title}"),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(_message.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
