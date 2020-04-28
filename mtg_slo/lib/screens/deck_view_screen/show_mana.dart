import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowMana extends StatelessWidget {
  final String _cost;
  final regExp = new RegExp(r"[^{\}]+(?=})");

  List _images = List<Container>();

  ShowMana(this._cost, BuildContext context) {
    for (var x in regExp.allMatches(_cost).map((m) => m[0])) {
      _images.add(new Container(
          child: SvgPicture.asset('assets/icons/' + x + '.svg', height: 22.5, width: 22.5)
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Wrap(
      children: _images,
    );
  }
}