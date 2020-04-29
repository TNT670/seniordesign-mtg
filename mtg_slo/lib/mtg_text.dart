import 'package:flutter/material.dart';

class MTGText extends StatelessWidget {

  var _mtgText;
  static const Color _defaultColor = const Color(0xFFFFF8E8);

  MTGText(String txt, double size, [Color color = _defaultColor, TextAlign align = TextAlign.left]) {
    _mtgText = RichText(textAlign: align, text: TextSpan(
        text: txt,
        style: TextStyle(
          fontFamily: 'Magic',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.bold,
        )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _mtgText;
  }
}