import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/screens/results_screen/results.dart';

// TODO: (post-presentation 2): make screen stateful to account for different
// land types

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final results = Provider.of<Results>(context);
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.blueGrey,
              onPressed: () async {
                print(await results.multiply(5.0, 10.0));
              }
           )
          )
        ]
      )
    );
  }
}