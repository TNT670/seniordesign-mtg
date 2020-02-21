import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManaDisplay extends StatelessWidget {
  final String _assetPath;

  ManaDisplay(this._assetPath);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: SvgPicture.asset(
        _assetPath,
        height: 50.0,
        width: 50.0,
        allowDrawingOutsideViewBox: true,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25.0,
            spreadRadius: 0.25
          )
        ]
      )
    );
  }
}