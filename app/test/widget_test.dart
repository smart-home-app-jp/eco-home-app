import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eco_home_app/main.dart';

void main() {
  testWidgets('Eco Home dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Eco Home'), findsOneWidget);
    expect(find.text('Поточна температура'), findsWidgets);

    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is NavigationDestination && widget.label == 'Опалення',
      ),
    );
    await tester.pump();
    expect(find.text('Ручне керування'), findsOneWidget);

    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is NavigationDestination && widget.label == 'Налаштування',
      ),
    );
    await tester.pump();
    expect(find.text('Годинник пристрою'), findsOneWidget);
  });
}
