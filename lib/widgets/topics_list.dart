import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.65,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: ListView.builder(
              itemCount: _topics.length,
              itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
                value: _topics[idx],
                child: Card(
                  elevation: 10,
                  child: TopicTile(_topics[idx]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
