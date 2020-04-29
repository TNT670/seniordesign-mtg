import 'package:flutter/material.dart';
import 'package:mtg_slo/screens/results_screen/results_row.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:mtg_slo/screens/results_screen/results.dart';
import 'package:mtg_slo/global_states.dart';

// TODO: (post-presentation 2): make screen stateful to account for different
// land types

class ResultsScreen extends StatelessWidget {

  final _wubrg = ["W", "U", "B", "R", "G"];

  List<ResultsRow> buildRows(List resultsList) {
    List<ResultsRow> allResults = List<ResultsRow>();
    for (int i=0; i<_wubrg.length; i++) {
      if (resultsList[i] != 0)
        allResults.add(ResultsRow(_wubrg[i], resultsList[i]));
    }
    return allResults;
  }

  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    //final results = Provider.of<Results>(context);
    final results = globalStates.getResults;
    final resultsList = results.toList();
    int count = 0;
    for (int i = 0; i < resultsList.length; i++) {
        if (resultsList[i] == 0) {
          count++;
        }
      }
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Results",
                style: TextStyle(
                  fontFamily: 'Magic',
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildRows(resultsList),
        )
      );

  }
}
