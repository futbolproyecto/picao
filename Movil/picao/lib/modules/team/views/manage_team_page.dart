import 'package:flutter/material.dart';
import 'package:picao/modules/team/views/team_players_page.dart';
import 'package:picao/modules/widgets/ui_text.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: UiText(text: 'Administrar equipo').titlePrimaryColor(),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 3,
              color: Colors.white,
              child: SizedBox(
                width: screenSize.width * 0.8,
                height: 200,
                child: const Center(
                    child: Text(
                        'Informacion de equipo: Partidos ganados, empatados, logo, nombre, observaciones')),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: ContainedTabBarView(
            tabs: [
              UiText(text: 'Jugadores').phraseBlack(),
              UiText(text: 'Configuracion').phraseBlack(),
            ],
            tabBarProperties: TabBarProperties(
                height: 80,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: const Offset(1, -1),
                      ),
                    ],
                  ),
                ),
                alignment: TabBarAlignment.center,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black),
            views: [
              const TeamPlayers(),
              Container(color: Colors.red),
            ],
          ))
        ],
      ),
    );
  }
}
