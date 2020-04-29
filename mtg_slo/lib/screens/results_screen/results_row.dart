import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: Text(""),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: new EdgeInsets.only(left: 15.0),
            child: RichText(
            text: TextSpan(
              text: _landCount.toString() + "\t" + getLandName(),
              style: TextStyle(
                fontFamily: 'Magic',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              )
            )
            )
          )
        ),
        Expanded(
          flex: 1,
          child: _icon,
        ),
        Expanded(
          flex: 1,
          child: Text(""),
        )
      ]
    );
  }
}