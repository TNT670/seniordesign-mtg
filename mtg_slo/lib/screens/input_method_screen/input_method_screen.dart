import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/deck_states.dart';

class InputSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deckStates = Provider.of<DeckStates>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Select an input method",
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
                color: Colors.orangeAccent,
                onPressed: () {
                  deckStates.clear();
                  Navigator.pushNamed(context, '/manual');
                },
                child: RichText(
                  text: TextSpan(
                    text: "Manual Entry",
                    style: TextStyle(
                      fontFamily: 'Magic', color: Colors.black87,
                      fontSize: 40.0, fontWeight: FontWeight.bold,
                    )
                  )
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.purpleAccent,
                onPressed: () {
                },
                child: RichText(
                    text: TextSpan(
                        text: "Deck Entry",
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
                color: Colors.yellowAccent,
                onPressed: () {
                },
                child: RichText(
                    text: TextSpan(
                        text: "Camera",
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