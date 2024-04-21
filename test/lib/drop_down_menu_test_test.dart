import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final entries = <DropdownMenuEntry<Text>>[
    for (int i = 0; i < 7; i++)
      DropdownMenuEntry(
        label: '$i-Text',
        value: Text('$i-Text', key: ValueKey('value=$i')),
        leadingIcon: Text('$i', key: ValueKey('key=$i')),
      )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownMenu<Text>(
          initialSelection: entries[1].value,
          dropdownMenuEntries: entries,
        ),
      ),
    );
  }
}

void main() {
  testWidgets('DropMenuTest', (tester) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));

    final menu = find.byType(DropdownMenu<Text>);
    expect(menu, findsNWidgets(1));
    expect(menu, findsNWidgets(1));

    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('value=$i'));
      expect(key, findsNWidgets(0)); // 0 !!!!
    }

    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('key=$i'));
      expect(key, findsNWidgets(1)); // 1 !!!!
    }

    await tester.tap(menu);
    await tester.pumpAndSettle();
    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('key=$i'));
      expect(key, findsNWidgets(2)); // 2 !!!!
    }

    // below is just repetition of above tests

    await tester.tap(find.byKey(ValueKey('key=5')).at(1));
    await tester.pumpAndSettle();
    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('key=$i'));
      expect(key, findsNWidgets(1)); // 1 !!!!
    }

    await tester.tap(menu);
    await tester.pumpAndSettle();
    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('key=$i'));
      expect(key, findsNWidgets(2)); // 2 !!!!
    }

    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('value=$i'));
      expect(key, findsNWidgets(0)); // 0 !!!!
    }

    await tester.tap(find.byKey(ValueKey('key=2')).at(1));
    await tester.pumpAndSettle();
    for (int i = 0; i < 7; i++) {
      final key = find.byKey(ValueKey('value=$i'));
      expect(key, findsNWidgets(0)); // 0 !!!!
    }
  });
}
