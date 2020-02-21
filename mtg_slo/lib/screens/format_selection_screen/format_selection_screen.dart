import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/global_states.dart';

class FormatSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "MTG: Statistical Land Optimization",
            style: TextStyle(
              fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
            )
          )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.redAccent,
              onPressed: () {
                globalStates.setFormat("Standard40");
                Navigator.pushNamed(context, '/second');
              },
              child: RichText(
                  text: TextSpan(
                      text: "Standard: 40 Cards",
                      style: TextStyle(
                        fontFamily: 'Magic', color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold,
                      )
                  )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                globalStates.setFormat("Standard60");
                Navigator.pushNamed(context, '/second');
              },
              child: RichText(
                  text: TextSpan(
                      text: "Standard: 60 Cards",
                      style: TextStyle(
                        fontFamily: 'Magic', color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold,
                      )
                  )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.greenAccent,
              onPressed: () {
                globalStates.setFormat("Commander");
                Navigator.pushNamed(context, '/second');
              },
              child: RichText(
                  text: TextSpan(
                      text: "Commander",
                      style: TextStyle(
                        fontFamily: 'Magic', color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold,
                      )
                  )
              ),
            ),
          ),
        ]
      ),
    );
  }
}