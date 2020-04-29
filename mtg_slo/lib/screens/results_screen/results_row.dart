import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../mtg_text.dart';

class ResultsRow extends StatelessWidget {
  final String _landColor;
  final int _landCount;

  String _assetPath;

  Container _icon;

  String getLandName() {
    if (_landColor == "W")
      return "Plains";
    if (_landColor == "U")
      return "Islands";
    if (_landColor == "B")
      return "Swamps";
    if (_landColor == "R")
      return "Mountains";
    if (_landColor == "G")
      return "Forests";
  }

  ResultsRow(this._landColor, this._landCount) {
    _assetPath = "assets/icons/" + _landColor + ".svg";
    _icon = new Container(
      child: SvgPicture.asset(_assetPath, height: 50.0, width: 50.0)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: new EdgeInsets.only(left: 30.0),
            child: MTGText(_landCount.toString() + "\t\t\t" + getLandName(), 25.0, Colors.black87)
          )
        ),
        Expanded(
          flex: 1,
          child: _icon,
        ),
      ]
    );
  }
}