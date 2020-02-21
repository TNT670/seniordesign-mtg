import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'code_state.dart';

class ColorIdentityDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final codeState = Provider.of<CodeState>(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: codeState.setIcons(),
          ),
          RichText(
            text: TextSpan(
              text: codeState.getIdentity,
              style: TextStyle(
                color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold
              )
            )
          )
        ]
      )
    );
  }
}