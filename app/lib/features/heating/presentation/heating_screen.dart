import 'package:flutter/material.dart';

import '../../../data/simulation/arduino_simulation_engine.dart';
import '../../../domain/models/arduino_home.dart';
import '../../../widgets/heating_status_card.dart';

class HeatingScreen extends StatelessWidget {
  const HeatingScreen({super.key, required this.engine});

  final ArduinoSimulationEngine engine;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ArduinoHome>(
      valueListenable: engine,
      builder: (context, home, _) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ручне керування',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => engine.processCommand('rel off'),
                            icon: const Icon(Icons.power_settings_new),
                            label: const Text('Увімкнути'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => engine.processCommand('rel on'),
                            icon: const Icon(Icons.power_off),
                            label: const Text('Вимкнути'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            HeatingStatusCard(home: home),
          ],
        );
      },
    );
  }
}
