import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final entries = <DropdownMenuEntry<Text>>[
    for (int i = 0; i < 7; i++)
      DropdownMenuEntry(
        value: Text(
          '$i-Text',
          key: ValueKey('value=$i'),
        ),
        label: '$i-Text',
        leadingIcon: Text(
          '$i',
          key: ValueKey('key=$i'),
        ),
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
