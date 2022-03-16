import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../screens/general_screen.dart';
import './../utils/auth.dart';
import './../widgets/profile.dart';
import './../widgets/topics_list.dart';

import '../utils/topics.dart';

class PrivateAreaWidget extends StatelessWidget {
  const PrivateAreaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitCubeGrid(
          color: Color.fromRGBO(243, 1, 0, 1.0),
          size: 50.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Área de socio",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(8.0),
              childAspectRatio: 1,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      GeneralScreen.routeName,
                      arguments: {
                        "widget": const Profile(),
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.lightUserCog,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          "Perfil",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.loaderOverlay.show();

                    Provider.of<Topics>(context, listen: false)
                        .fetchTopics(
                          1,
                          Provider.of<Auth>(context, listen: false).token,
                        )
                        .then(
                          (_) => {
                            context.loaderOverlay.hide(),
                            Navigator.pushNamed(
                              context,
                              GeneralScreen.routeName,
                              arguments: {
                                "widget":
                                    const TopicList(1, "Listas Generales"),
                              },
                            )
                          },
                        );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.lightList,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Listas Generales",
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.loaderOverlay.show();
                    Provider.of<Topics>(context, listen: false)
                        .fetchTopics(
                          2,
                          Provider.of<Auth>(context, listen: false).token,
                        )
                        .then(
                          (_) => {
                            context.loaderOverlay.hide(),
                            Navigator.pushNamed(
                              context,
                              GeneralScreen.routeName,
                              arguments: {
                                "widget": const TopicList(
                                    2, "Listas de Grupos de trabajo"),
                              },
                            )
                          },
                        );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.lightUsers,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Grupos de Trabajo",
                                maxLines: 2,
                                softWrap: true,
                                style: Theme.of(context).textTheme.headline5,
                              )),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
