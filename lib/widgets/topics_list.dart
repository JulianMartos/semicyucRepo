import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semicyuc2/models/utils.dart';
import 'package:semicyuc2/utils/topics.dart';

import 'other_widgets.dart';

class TopicList extends StatelessWidget {
  final int category;
  final String title;

  const TopicList(this.category, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _topicsData = Provider.of<Topics>(context);
    final _topics = _topicsData.topics;
    return _topics.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "No esta subscrito a ningun topico de esta categorai",
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
                  title,
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
                    itemCount: _topics.length,
                    itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
                      value: _topics[idx],
                      child: TopicTile(_topics[idx]),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
