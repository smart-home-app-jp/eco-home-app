import 'package:flutter/material.dart';

import '../../../data/simulation/arduino_simulation_engine.dart';
import '../../../domain/models/arduino_home.dart';
import '../../../widgets/heating_status_card.dart';
import '../../heating/presentation/heating_screen.dart';
import '../../schedule/presentation/schedule_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ArduinoSimulationEngine _engine = ArduinoSimulationEngine();
  int _currentIndex = 0;

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _OverviewPage(engine: _engine),
      HeatingScreen(engine: _engine),
      ScheduleScreen(engine: _engine),
      SettingsScreen(engine: _engine),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Home'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Синхронізувати час',
            onPressed: _syncTime,
            icon: const Icon(Icons.sync),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _currentIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Огляд',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            selectedIcon: Icon(Icons.local_fire_department),
            label: 'Опалення',
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule_outlined),
            selectedIcon: Icon(Icons.schedule),
            label: 'Розклад',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Налаштування',
          ),
        ],
      ),
    );
  }

  void _syncTime() {
    final now = DateTime.now();
    final hh = now.hour.toString().padLeft(2, '0');
    final mm = now.minute.toString().padLeft(2, '0');
    _engine.processCommand('time-$hh:$mm');
  }
}

class _OverviewPage extends StatelessWidget {
  const _OverviewPage({required this.engine});

  final ArduinoSimulationEngine engine;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ArduinoHome>(
      valueListenable: engine,
      builder: (context, home, _) {
        final colors = Theme.of(context).colorScheme;
        final heating = home.heatingOn;

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: heating
                    ? colors.primaryContainer
                    : colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Поточна температура',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        home.temperatureC.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8, left: 4),
                        child: Text('°C'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: Icon(
                          heating
                              ? Icons.local_fire_department
                              : Icons.local_fire_department_outlined,
                        ),
                        label: Text(
                          heating ? 'Опалення увімкнено' : 'Опалення вимкнено',
                        ),
                      ),
                      Chip(
                        avatar: Icon(
                          home.isTimerOn
                              ? Icons.schedule
                              : Icons.schedule_outlined,
                        ),
                        label: Text(
                          home.isTimerOn
                              ? 'Таймер · ${home.timerText}'
                              : 'Таймер вимкнено',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            HeatingStatusCard(home: home),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.cloud_off_outlined, size: 18, color: colors.outline),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Локальна симуляція прошивки',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
