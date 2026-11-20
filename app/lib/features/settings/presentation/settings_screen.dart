import 'package:flutter/material.dart';

import '../../../data/simulation/arduino_simulation_engine.dart';
import '../../../domain/models/arduino_home.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.engine});

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
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Годинник пристрою'),
                    subtitle: Text(home.clockText),
                    trailing: FilledButton(
                      onPressed: () {
                        final now = DateTime.now();
                        engine.processCommand(
                          'time-${now.hour.toString().padLeft(2, '0')}:'
                          '${now.minute.toString().padLeft(2, '0')}',
                        );
                      },
                      child: const Text('Синхронізувати'),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.speed),
                    title: const Text('Корекція такту годинника'),
                    subtitle: Text(
                      '${home.timeCorrection.toStringAsFixed(2)} × 1 секунда',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Slider(
                      min: 0.5,
                      max: 2,
                      divisions: 30,
                      value: home.timeCorrection.clamp(0.5, 2).toDouble(),
                      onChanged: (value) => engine.processCommand(
                        'timeCorrection-${value.toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
