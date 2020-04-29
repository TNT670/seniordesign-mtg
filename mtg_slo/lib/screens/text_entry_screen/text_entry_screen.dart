import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/screens/text_entry_screen/text_entry_processing.dart';
import 'package:mtg_slo/card.dart';
import 'package:mtg_slo/deck_states.dart';

import '../../deck.dart';


class TextEntryScreen extends StatefulWidget {
  @override
  _TextEntryScreenState createState() => _TextEntryScreenState();
}

class _TextEntryScreenState extends State<TextEntryScreen> {
  String _boxText, _currentCard;
  FocusNode boxFocusNode;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _currentCard = "Input deck in MTG: Online format";
    boxFocusNode = FocusNode();
  }

  @override
  void dispose() {
    boxFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textEntryProcessing = Provider.of<TextEntryProcessing>(context);
    final deckStates = Provider.of<DeckStates>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Text Entry",
                style: TextStyle(
                  fontFamily: 'Magic',
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget> [
              Text('$_currentCard'),
              Expanded(
                flex: 3,
                child: !_loading ? Container(
                    child: TextField(
                      autofocus: true,
                      focusNode: boxFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Input deck'
                      ),
                      onChanged: (text) {
                        _boxText = text;
                      },
                      )
                ) : FractionallySizedBox(
                        heightFactor: .25,
                        widthFactor: .33,
                        child: CircularProgressIndicator(
                          strokeWidth: 25,
                        )
                )
              )
            ]
           )
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          boxFocusNode.unfocus();

          setState(() {
            _loading = !_loading;
          });

          var cardListMap = textEntryProcessing.processText(_boxText);
          var cardListObj = List<MTGCard>();
          Deck cardListObjFinal = Deck("tempname");

          for (var key in cardListMap.keys) {
            setState(() { _currentCard = key;});
            cardListObj.add(await textEntryProcessing.fetchCards(key, cardListMap[key]));
          }

          for (var card in cardListObj) {
            if (!card.getTypeLine.contains('Land'))
              for (int i=0; i<card.numCards; i++) {
                cardListObjFinal.addCard(card);
              }
          }

          print(cardListObjFinal.length);
          /* for (var card in cardListObjFinal.getCards) {
            print(card.getCardName);
          } */
          deckStates.decks.add(cardListObjFinal);

          if (cardListObjFinal.length < 40 )
            deckStates.decks[0].setFormat("Standard 40");
          else if (cardListObjFinal.length < 60)
            deckStates.decks[0].setFormat("Standard 60");
          else
            deckStates.decks[0].setFormat("Commander");

          // print(deckStates.decks[0].toJson());

          Navigator.pushNamed(context, '/deck');

        },
        label: Text('Next'),
        icon: Icon(Icons.arrow_forward),
      )
      );
  }
}