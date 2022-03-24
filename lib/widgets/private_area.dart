import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './../screens/general_screen.dart';
import './../utils/auth.dart';
import './../widgets/profile.dart';
import './../widgets/topics_list.dart';
import './private_area_button.dart';

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
            child: AutoSizeText(
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
              childAspectRatio: 0.95,
              children: const [
                PrivateAreaButton(
                  FontAwesomeIcons.lightUser,
                  "mi \n PERFIL",
                  Profile(),
                  1,
                ),
                PrivateAreaButton(
                  FontAwesomeIcons.lightList,
                  "listas GENERALES",
                  TopicList(1, "Listas Generales"),
                  1,
                ),
                PrivateAreaButton(
                  FontAwesomeIcons.lightUsers,
                  "grupos de TRABAJO",
                  TopicList(2, "Grupos de Trabajo"),
                  2,
                ),
                PrivateAreaButton(
                  FontAwesomeIcons.lightChartNetwork,
                  "otras SOCIEDADES",
                  TopicList(3, "Sociedades Autonómicas y territoriales"),
                  3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
