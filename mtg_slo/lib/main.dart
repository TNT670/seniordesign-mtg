import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/global_states.dart';
import 'package:mtg_slo/deck_states.dart';
import 'package:mtg_slo/screens/results_screen/results.dart';
import 'package:mtg_slo/screens/format_selection_screen/format_selection_screen.dart';
import 'package:mtg_slo/screens/mana_selection_screen/mana_selection_screen.dart';
import 'package:mtg_slo/screens/input_method_screen/input_method_screen.dart';
import 'package:mtg_slo/screens/manual_selection_screen/manual_selection_screen.dart';
import 'package:mtg_slo/screens/results_screen/results_screen.dart';
import 'package:mtg_slo/screens/camera_screen/camera.dart';
import 'package:mtg_slo/screens/text_entry_screen/text_entry_screen.dart';
import 'package:mtg_slo/screens/text_entry_screen/text_entry_processing.dart';
import 'package:mtg_slo/screens/deck_view_screen/deck_view_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalStates()),
        ChangeNotifierProvider(create: (context) => DeckStates()),
        ChangeNotifierProvider(create: (context) => Results()),
        ChangeNotifierProvider(create: (context) => TextEntryProcessing()),
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
      initialRoute: '/input',
      routes: {
        '/format': (context) => FormatSelectionScreen(),
        '/mana': (context) => ManaSelectionScreen(),
        '/input': (context) => InputSelectionScreen(),
        '/manual': (context) => ManualSelectionScreen(),
        '/results': (context) => ResultsScreen(),
        '/camera': (context) => CameraScreen(),
        '/text': (context) => TextEntryScreen(),
        '/deck': (context) => DeckViewScreen(),
      }
    );
  }
}