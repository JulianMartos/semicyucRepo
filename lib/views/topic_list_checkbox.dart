import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../models/utils.dart';
import './../utils/auth.dart';
import './../utils/suscriptionTopics.dart';

class CheckBoxList extends StatefulWidget {
  final int idCategoria;
  final String emptyMessage;

  const CheckBoxList(this.idCategoria, this.emptyMessage, {Key? key})
      : super(key: key);

  @override
  State<CheckBoxList> createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
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
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.emptyMessage,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Solicito pertenecer a los siguientes grupos de trabajo",
                        ),
                      ),
                      Container(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  height: 10,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                  color: darkBlue,
                                ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _listTopics.length,
                            itemBuilder: (ctx, idx) {
                              bool _checked = _listTopics[idx].subscribed;
                              return CheckboxListTile(
                                activeColor: Theme.of(context).primaryColor,
                                title: Text(
                                  _listTopics[idx].title,
                                  // style: Theme.of(context).textTheme.headline5,
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
                    ],
                  ),
                ),
    );
  }
}
