import 'package:flutter/material.dart';
import 'mana_display.dart';

class ResultDisplay extends StatelessWidget {
  final ManaDisplay _manaDisplay;
  final int _landCount;

  ResultDisplay(this._manaDisplay, this._landCount);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        _manaDisplay,
        RichText(
            text: TextSpan(
                text: _landCount.toString(),
                style: TextStyle(
                    fontFamily: 'Magic', color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold
                )
            )
        ),
      ]
    );
  }
}