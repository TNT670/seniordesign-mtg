import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../card.dart';
import 'show_mana.dart';
import 'package:mtg_slo/deck.dart';

class CardView extends StatefulWidget {

  MTGCard _card = MTGCard();
  CardView(this._card);

  String get getCardName => _card.getCardName;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        direction: Axis.horizontal,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RichText(
              text: TextSpan(
                text: "${widget._card.numCards.toString()}\t${widget._card.getCardName}",
                style: TextStyle(
                  fontFamily: 'Magic',
                  color: Colors.grey,
                  fontSize: 17.5,
                  fontWeight: FontWeight.bold
                  )
                )
              )
            ),
          //Text(widget.cardCount.toString()),
          //Text(widget._card.getCardName),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ShowMana(widget._card.getManaCost, context),
          )
          // Image.network(widget._card.getImagePath),
        ],
        );
  }
}