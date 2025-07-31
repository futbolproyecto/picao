import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';

class ListReservationFileds extends StatelessWidget {
  const ListReservationFileds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UiButtoms().backButtom(),
          Column(
            children: [
              const SizedBox(height: 50),
              UiText(text: S.of(context).misReservas).title(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        elevation: 3,
                        color: Theme.of(context).colorScheme.surface,
                        child: ListTile(
                          onTap: () => {},
                          title: UiText(text: 'Golpi').phraseSemiBold(),
                          subtitle: Column(
                            children: [
                              _buildInfoRow(
                                  '${S.of(context).fecha}:', '2025-07-31'),
                              _buildInfoRow('${S.of(context).hora}:', '15:00'),
                              _buildInfoRow(
                                  '${S.of(context).estado}:', 'Pendiente'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [UiText(text: label).phrase(), UiText(text: value).phrase()],
      ),
    );
  }
}
