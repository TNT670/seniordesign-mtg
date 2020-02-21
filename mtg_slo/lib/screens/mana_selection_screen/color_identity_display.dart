import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/global_states.dart';

class ColorIdentityDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: globalStates.setDisplays(),
          ),
          RichText(
            text: TextSpan(
              text: globalStates.getIdentity,
              style: TextStyle(
                  fontFamily: 'Magic', color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold
              )
            )
          )
        ]
      )
    );
  }
}