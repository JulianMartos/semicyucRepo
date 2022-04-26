import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/utils/auth.dart';
import 'package:semicyuc2/utils/notificationTopics.dart';

import '../models/http_exception.dart';
import '../models/topic.dart';
import '../models/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = false;
  var _topicList1 = [];
  var _topicList2 = [];
  var _topicList3 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
  }

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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoading) {
      await Provider.of<NotificationsTopics>(context, listen: false)
          .fetchTopics(1, Provider.of<Auth>(context, listen: false).token)
          .then((value) {
        print("Lista 1");
        _topicList1 =
            Provider.of<NotificationsTopics>(context, listen: false).topics;
      });
      await Provider.of<NotificationsTopics>(context, listen: false)
          .fetchTopics(2, Provider.of<Auth>(context, listen: false).token)
          .then((value) {
        _topicList2 =
            Provider.of<NotificationsTopics>(context, listen: false).topics;
      });
      await Provider.of<NotificationsTopics>(context, listen: false)
          .fetchTopics(3, Provider.of<Auth>(context, listen: false).token)
          .then((value) {
        _topicList3 =
            Provider.of<NotificationsTopics>(context, listen: false).topics;
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: SpinKitCubeGrid(
              color: Color.fromRGBO(243, 1, 0, 1.0),
              size: 50.0,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Ajustes".toUpperCase(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: lightBlue,
                    border: Border.all(
                      color: darkBlue,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                            "Listas Generales",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          initiallyExpanded: false,
                          children: [
                            _topicList1.isEmpty
                                ? ListTile(
                                    title: Text("No hay listas disponibles."),
                                  )
                                : ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 10,
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 10,
                                          color: midBlue,
                                        ),
                                    shrinkWrap: true,
                                    itemCount: _topicList1.length,
                                    itemBuilder: (ctx, idx) {
                                      return SwitchListTile.adaptive(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        title: Text(
                                          _topicList1[idx].title,
                                        ),
                                        value: _topicList1[idx].subscribed,
                                        onChanged: (value) async {
                                          try {
                                            setState(() {
                                              Provider.of<Topic>(context,
                                                      listen: false)
                                                  .subscribe(
                                                Provider.of<Auth>(context,
                                                        listen: false)
                                                    .token,
                                              );
                                            });
                                          } on HttpException catch (error) {
                                            _showErrorDialog(error.toString());
                                          }
                                        },
                                      );
                                    }),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            "Grupos de Trabajo",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          initiallyExpanded: false,
                          children: [
                            _topicList2.isEmpty
                                ? ListTile(
                                    title: Text(
                                        "No hay grupos de trabajo disponibles"),
                                  )
                                : ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 10,
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 10,
                                          color: midBlue,
                                        ),
                                    shrinkWrap: true,
                                    itemCount: _topicList2.length,
                                    itemBuilder: (ctx, idx) {
                                      return SwitchListTile.adaptive(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        title: Text(
                                          _topicList2[idx].title,
                                        ),
                                        value: _topicList2[idx].subscribed,
                                        onChanged: (value) async {
                                          try {
                                            setState(() {
                                              Provider.of<Topic>(context,
                                                      listen: false)
                                                  .subscribe(
                                                Provider.of<Auth>(context,
                                                        listen: false)
                                                    .token,
                                              );
                                            });
                                          } on HttpException catch (error) {
                                            _showErrorDialog(error.toString());
                                          }
                                        },
                                      );
                                    }),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            "Listas Generales",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          initiallyExpanded: false,
                          children: [
                            _topicList3.isEmpty
                                ? ListTile(
                                    title:
                                        Text("No hay sociedades disponibles"),
                                  )
                                : ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 10,
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 10,
                                          color: midBlue,
                                        ),
                                    shrinkWrap: true,
                                    itemCount: _topicList3.length,
                                    itemBuilder: (ctx, idx) {
                                      return SwitchListTile.adaptive(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        title: Text(
                                          _topicList3[idx].title,
                                        ),
                                        value: _topicList3[idx].subscribed,
                                        onChanged: (value) async {
                                          try {
                                            setState(() {
                                              Provider.of<Topic>(context,
                                                      listen: false)
                                                  .subscribe(
                                                Provider.of<Auth>(context,
                                                        listen: false)
                                                    .token,
                                              );
                                            });
                                          } on HttpException catch (error) {
                                            _showErrorDialog(error.toString());
                                          }
                                        },
                                      );
                                    }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
