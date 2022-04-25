import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../models/utils.dart';
import './../utils/auth.dart';
import './../utils/suscriptionTopics.dart';

class CheckBoxList extends StatefulWidget {
  final int idCategoria;

  const CheckBoxList(this.idCategoria, {Key? key}) : super(key: key);

  @override
  State<CheckBoxList> createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isLoading) {
      Provider.of<SuscriptionTopics>(context)
          .fetchGtTopic(widget.idCategoria,
              Provider.of<Auth>(context, listen: false).token)
          .then((_) {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _listTopics = Provider.of<SuscriptionTopics>(context).topics;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitCubeGrid(
          color: Color.fromRGBO(243, 1, 0, 1.0),
          size: 50.0,
        ),
      ),
      child: _isLoading
          ? const Center(
              child: SpinKitCubeGrid(
                color: Color.fromRGBO(243, 1, 0, 1.0),
                size: 50.0,
              ),
            )
          : _listTopics.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "No hay grupos de trabajo disponibles",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Grupos de Trabajo",
                        style: Theme.of(context).textTheme.headline3,
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
                              bool _checked = _listTopics[idx].subscribed;
                              return CheckboxListTile(
                                activeColor: Theme.of(context).primaryColor,
                                title: Text(
                                  _listTopics[idx].title,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                value: _checked,
                                onChanged: (value) async {
                                  if (value!) {
                                    Provider.of<SuscriptionTopics>(context,
                                            listen: false)
                                        .addTopic(_listTopics[idx].id);
                                  } else {
                                    Provider.of<SuscriptionTopics>(context,
                                            listen: false)
                                        .removeTopic(_listTopics[idx].id);
                                  }
                                  setState(() {
                                    _listTopics[idx].subscribed = value;
                                  });
                                },
                              );
                            }),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          primary: Theme.of(context).primaryColor,
                          shape: const StadiumBorder(),
                          fixedSize: const Size(250, 35),
                        ),
                        onPressed: () {
                          context.loaderOverlay.show();
                          Provider.of<SuscriptionTopics>(context, listen: false)
                              .saveTopics(
                                  Provider.of<Auth>(context, listen: false)
                                      .token)
                              .then((value) {
                            context.loaderOverlay.hide();
                            value ? Navigator.of(context).pop() : null;
                          });
                        },
                        child: Text(
                          "Guardar".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}