import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/screens/mana_selection_screen/color_identity_selection.dart';
import 'package:mtg_slo/screens/mana_selection_screen/color_identity_display.dart';
import 'package:mtg_slo/global_states.dart';

class ManaSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: globalStates.getFormat,
                style: TextStyle(
                  fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                )
            )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 10,
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: "Choose your color identity",
                  style: TextStyle(
                    fontFamily: 'Magic', color: Colors.black87, fontSize: 35.0, fontWeight: FontWeight.bold,
                  )
                )
              )
            )
          ),
          Flexible(
            flex: 75,
            child: ColorIdentitySelection()
          ),
          Flexible(
            flex: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColorIdentityDisplay(),
              ]
            )
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // go to next screen
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.deepPurple
      )
    );
  }
}