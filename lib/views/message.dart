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
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "De: ",
                style: labelBold,
              ),
              Text(
                _message.sender,
                style: labelRegular,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Para: ",
                style: labelBold,
              ),
              Text(
                _message.nombreTopico,
                style: labelRegular,
              ),
            ],
          ),
          const SizedBox(height: 5),
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
            _message.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          if (_message.file != null)
            Link(
              target: LinkTarget.self,
              uri: Uri.parse("https://area-privada.semicyuc.org/uploads/" +
                  _message.file!),
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
                  color: grey,
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
