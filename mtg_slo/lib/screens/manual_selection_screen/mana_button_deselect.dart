import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/deck_states.dart';

class ManaButtonDeselect extends StatelessWidget {
  final String _assetPath;

  ManaButtonDeselect(this._assetPath);

  @override
  Widget build(BuildContext context) {
    final deckStates = Provider.of<DeckStates>(context);
    return SizedBox.fromSize(
      size: Size(60.0, 60.0),
      child: FloatingActionButton(
        onPressed: () {
          deckStates.decMana(_assetPath.substring(13, _assetPath.indexOf('.')));
        },
        child: SvgPicture.asset(
            _assetPath
        ),
      ),
    );
  }
}