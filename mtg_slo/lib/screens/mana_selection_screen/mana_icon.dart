import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/global_states.dart';

class ManaIcon extends StatelessWidget {
  final String _assetPath;
  final String _heroTag;

  String get assetPath {
    return _assetPath;
  }

  ManaIcon(this._assetPath, this._heroTag);

  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    return FloatingActionButton(
      heroTag: _heroTag,
      onPressed: () {
        globalStates.setCode(this);
      },
      child: Stack (
        children: [
          SvgPicture.asset(
            _assetPath,
            height: 5000.0,
            width: 5000.0,
            allowDrawingOutsideViewBox: true,
          ),
          Container(
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(globalStates.getOpacity(this)),
              shape: BoxShape.circle
            )
          ),
        ]
      )
    );
  }
}