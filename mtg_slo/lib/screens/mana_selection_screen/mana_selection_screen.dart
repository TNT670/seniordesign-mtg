import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'color_identity_selection.dart';
import 'color_identity_display.dart';

class ManaSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MTG: Statistical Land Optimization'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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