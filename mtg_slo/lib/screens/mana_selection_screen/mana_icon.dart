import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'code_state.dart';

class ManaIcon extends StatelessWidget {
  final String _assetPath;
  bool pressed = false;

  String get assetPath {
    return _assetPath;
  }

  bool get pressedStatus {
    return pressed;
  }

  ManaIcon(this._assetPath);

  @override
  Widget build(BuildContext context) {
    final codeState = Provider.of<CodeState>(context);
    return FloatingActionButton(
      onPressed: () {
        pressed = !pressed;
        codeState.setCode(this);
      },
      child: SvgPicture.asset(
        _assetPath,
        height: 5000.0,
        width: 5000.0,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}