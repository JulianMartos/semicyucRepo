import 'package:SEMICYUC/views/voting.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './../views/settings.dart';
import './../views/topic_list_switch.dart';
import './../widgets/list_topic_button.dart';
import './profile.dart';
import './topic_list_switch.dart';
import './topic_list_checkbox.dart';

class PrivateAreaWidget extends StatelessWidget {
  const PrivateAreaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitCubeGrid(
            color: Color.fromRGBO(243, 1, 0, 1.0),
            size: 50.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 10,
                right: 10,
              ),
              child: AutoSizeText(
                "Área de socio".toUpperCase(),
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 125).round(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(8.0),
                childAspectRatio: 0.95,
                children: const [
                  PrivateAreaButton(
                    FontAwesomeIcons.lightUser,
                    "mi \n PERFIL",
                    Profile(),
                  ),
                  PrivateAreaButton(
                    FontAwesomeIcons.lightList,
                    "listas GENERALES",
                    SwitchList(
                      1,
                      "Listas Generales",
                      "No hay listas disponibles.",
                    ),
                  ),
                  PrivateAreaButton(
                    FontAwesomeIcons.lightUsers,
                    "grupos de TRABAJO",
                    CheckBoxList(2, "Grupos de Trabajo",
                        "No hay grupos de Trabajo Disponible."),
                  ),
                  PrivateAreaButton(
                    FontAwesomeIcons.lightChartNetwork,
                    "otras SOCIEDADES",
                    SwitchList(
                      3,
                      "Sociedades Autonómicas y territoriales",
                      "No hay sociedades disponibles",
                    ),
                  ),
                  PrivateAreaButton(
                    FontAwesomeIcons.lightBoxBallot,
                    "\nVotaciones",
                    Voting(),
                  ),
                  PrivateAreaButton(
                    FontAwesomeIcons.lightCog,
                    "ajustes de Notificación",
                    SettingsPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
