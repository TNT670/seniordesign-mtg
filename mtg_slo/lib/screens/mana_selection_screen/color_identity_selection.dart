import 'package:flutter/material.dart';

import 'package:mtg_slo/screens/mana_selection_screen/mana_icon.dart';

class ColorIdentitySelection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Align(
            alignment: FractionalOffset(0.5, 0.05),
            child: SizedBox.fromSize(
              size: Size(125.0, 125.0),
              child: ManaIcon('assets/icons/W.svg', 'White'),
            )
          )
        ),
        Positioned(
            child: Align(
                alignment: FractionalOffset(0.05, 0.4),
                child: SizedBox.fromSize(
                  size: Size(125.0, 125.0),
                  child: ManaIcon('assets/icons/G.svg', 'Green'),
                )
            )
        ),
        Positioned(
            child: Align(
                alignment: FractionalOffset(0.95, 0.4),
                child: SizedBox.fromSize(
                  size: Size(125.0, 125.0),
                  child: ManaIcon('assets/icons/B.svg', 'Black'),
                )
            )
        ),
        Positioned(
            child: Align(
                alignment: FractionalOffset(0.225, 0.9),
                child: SizedBox.fromSize(
                  size: Size(125.0, 125.0),
                  child: ManaIcon('assets/icons/R.svg', 'Red'),
                )
            )
        ),
        Positioned(
            child: Align(
                alignment: FractionalOffset(0.775, 0.9),
                child: SizedBox.fromSize(
                  size: Size(125.0, 125.0),
                  child: ManaIcon('assets/icons/U.svg', 'Blue'),
                )
            )
        ),
      ]
    );
  }
}