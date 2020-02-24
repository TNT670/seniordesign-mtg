import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/global_states.dart';
import 'package:mtg_slo/screens/format_selection_screen/format_selection_screen.dart';
import 'package:mtg_slo/screens/mana_selection_screen/mana_selection_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalStates()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG: SLO',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormatSelectionScreen(),
        '/second': (context) => ManaSelectionScreen(),
      }
    );
  }
}