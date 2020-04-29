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

Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};

MaterialColor colorCustom = MaterialColor(0xff990d35, color);

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
        primarySwatch: colorCustom,
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