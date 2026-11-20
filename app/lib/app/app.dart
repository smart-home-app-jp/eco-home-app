import 'package:flutter/material.dart';

import '../features/dashboard/presentation/dashboard_screen.dart';
import 'theme/app_theme.dart';

class EcoHomeApp extends StatelessWidget {
  const EcoHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Home',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const DashboardScreen(),
    );
  }
}

typedef MyApp = EcoHomeApp;
