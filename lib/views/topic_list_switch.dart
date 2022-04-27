import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import './../utils/notificationTopics.dart';
import '../models/utils.dart';
import './../utils/auth.dart';

class SwitchList extends StatefulWidget {
  final int idCategoria;
  final String emptyMessage;
  final String title;

  const SwitchList(this.idCategoria, this.title, this.emptyMessage, {Key? key})
      : super(key: key);

  @override
  State<SwitchList> createState() => _SwitchListState();
}

class _SwitchListState extends State<SwitchList> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Ha ocurrido un error'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Aceptar'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      Provider.of<NotificationsTopics>(context)
          .fetchTopics(widget.idCategoria,
              Provider.of<Auth>(context, listen: false).token)
          .then((_) {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _listTopics = Provider.of<NotificationsTopics>(context).topics;
    return _isLoading
        ? const Center(
            child: SpinKitCubeGrid(
              color: Color.fromRGBO(243, 1, 0, 1.0),
              size: 50.0,
            ),
          )
        : _listTopics.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.emptyMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      widget.title.toUpperCase(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.65,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: lightBlue,
                        border: Border.all(
                          color: darkBlue,
                          width: 1,
                        ),
                      ),
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                height: 10,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                                color: darkBlue,
                              ),
                          itemCount: _listTopics.length,
                          itemBuilder: (ctx, idx) {
                            return CheckboxListTile(
                              activeColor: Theme.of(context).primaryColor,
                              title: Text(
                                _listTopics[idx].title,
                                // style: Theme.of(context).textTheme.headline5,
                              ),
                              value: true,
                              onChanged: (bool? value) {},
                            );
                          }),
                    ),
                  ),
                ],
              );
  }
}
