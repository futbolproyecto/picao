import 'package:flutter/material.dart';
import 'package:picao/core/constants/constants.dart';

class TeamPlayers extends StatelessWidget {
  const TeamPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Icon(
          Icons.person_add_alt,
          size: 40,
          color: Constants.primaryColor,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      elevation: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Constants.secondaryColor,
                                  width: 3,
                                )),
                            child: ClipOval(
                              child: Image.asset('assets/img/usericon.png'),
                            ),
                          ),
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Text('Miguel Antonio Jimenez'),
                                  SizedBox(width: 15),
                                  Text('Posicion: Jugador')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Estado: Activo'),
                                  SizedBox(width: 15),
                                  Text('Celular: 3178523598')
                                ],
                              )
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
