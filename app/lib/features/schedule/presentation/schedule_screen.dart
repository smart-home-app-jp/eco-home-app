import 'package:flutter/material.dart';

import '../../../data/simulation/arduino_simulation_engine.dart';
import '../../../domain/models/arduino_home.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, required this.engine});

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Таймер опалення',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Switch(
                          value: home.isTimerOn,
                          onChanged: (value) => engine.processCommand(
                            value ? 'timer on' : 'timer off',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: home.timerHour,
                            minute: home.timerMinute,
                          ),
                        );
                        if (picked != null) {
                          engine.processCommand(
                            'timer-'
                            '${picked.hour.toString().padLeft(2, '0')}:'
                            '${picked.minute.toString().padLeft(2, '0')}',
                          );
                          engine.processCommand('timer on');
                        }
                      },
                      icon: const Icon(Icons.schedule),
                      label: Text(home.timerText),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _IntervalRow(
                      label: 'Увімкнення',
                      value: home.intervalOnMin,
                      onMinus: () => engine.processCommand(
                        'intervalOn-${home.intervalOnMin > 0 ? home.intervalOnMin - 1 : 0}',
                      ),
                      onPlus: () => engine.processCommand(
                        'intervalOn-${home.intervalOnMin < 59 ? home.intervalOnMin + 1 : 59}',
                      ),
                    ),
                    const Divider(),
                    _IntervalRow(
                      label: 'Вимкнення',
                      value: home.intervalOffMin,
                      onMinus: () => engine.processCommand(
                        'intervalOff-${home.intervalOffMin > 0 ? home.intervalOffMin - 1 : 0}',
                      ),
                      onPlus: () => engine.processCommand(
                        'intervalOff-${home.intervalOffMin < 59 ? home.intervalOffMin + 1 : 59}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IntervalRow extends StatelessWidget {
  const _IntervalRow({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  final String label;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        IconButton.outlined(onPressed: onMinus, icon: const Icon(Icons.remove)),
        SizedBox(
          width: 72,
          child: Text(
            '$value хв',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        IconButton.outlined(onPressed: onPlus, icon: const Icon(Icons.add)),
      ],
    );
  }
}
