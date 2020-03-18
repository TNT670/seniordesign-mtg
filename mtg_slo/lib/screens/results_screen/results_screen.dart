import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:mtg_slo/screens/results_screen/results.dart';
import 'package:mtg_slo/global_states.dart';

// TODO: (post-presentation 2): make screen stateful to account for different
// land types

class ResultsScreen extends StatelessWidget {
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
          children: [
            Text("Land Counts"),
            Text("White: " + resultsList[0].toString()),
            Text("Blue: " + resultsList[1].toString()),
            Text("Black: " + resultsList[2].toString()),
            Text("Red: " + resultsList[3].toString()),
            Text("Green: " + resultsList[4].toString()),
          ]
        )
      );
  }
}
