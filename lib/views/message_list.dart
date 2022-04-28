import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import './../models/utils.dart';
import '../models/http_exception.dart';
import './../utils/message.dart';
import './../screens/general_screen.dart';
import './../utils/auth.dart';
import './message.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

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
    if (Provider.of<MessageProvider>(context, listen: false)
        .messageList
        .isEmpty) {
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
    } else {
      _refreshMessages();
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

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    RegExp exp2 = RegExp(r"\n\n", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '').replaceAll(exp2, ' ');
    // return htmlText.replaceAll(exp, '');
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
            child: Text(
              'Mis Mensajes'.toUpperCase(),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.65,
            child: Container(
              margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: lightBlue,
                border: Border.all(
                  color: darkBlue,
                  width: 1,
                ),
              ),
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                displacement: 10,
                onRefresh: _refreshMessages,
                child: _messages.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "No hay mensajes en los topicos a los que esta subscrito",
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              primary: Theme.of(context).primaryColor,
                              shape: const StadiumBorder(),
                              fixedSize: const Size(150, 40),
                            ),
                            onPressed: _refreshMessages,
                            child: Text(
                              "Actualizar",
                              style: labelBold.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      )
                    : ListView.separated(
                        itemBuilder: (ctx, index) {
                          int idx = _messages.length - index - 1;
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _messages[idx].sender,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: darkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  _messages[idx].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: darkBlue,
                                    fontSize: 17,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(color: midBlue),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          " ${_messages[idx].nombreTopico}",
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  removeAllHtmlTags(_messages[idx].text),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, GeneralScreen.routeName,
                                  arguments: {
                                    'widget': MessageContent(_messages[idx].id),
                                  });
                            },
                          );
                        },
                        separatorBuilder: (ctx, idx) => sdivider,
                        itemCount: _messages.length,
                      ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Container(),
      );
    }
  }
}


//       return Container(
//         margin: EdgeInsets.symmetric(horizontal: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(3),
//           color: lightBlue,
//           border: Border.all(
//             color: darkBlue,
//             width: 1,
//           ),
//         ),
//         child: 
//       );
//     } else {
//       return Container();
//     }
//   }
// }
