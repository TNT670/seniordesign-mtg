import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/deck_states.dart';

class ManaButton extends StatelessWidget {
  final String _assetPath, _heroTag;

  ManaButton(this._assetPath, this._heroTag);

  String get getAssetPath => _assetPath;

  @override
  Widget build(BuildContext context) {
    final deckStates = Provider.of<DeckStates>(context);
    return SizedBox.fromSize(
      size: Size(85.0, 85.0),
      child: FloatingActionButton(
        heroTag: _heroTag,
        onPressed: () {
          deckStates.addMana(_assetPath.substring(13, _assetPath.indexOf('.')));
        },
        child: SvgPicture.asset(
            _assetPath
        ),
      ),
    );
  }
}