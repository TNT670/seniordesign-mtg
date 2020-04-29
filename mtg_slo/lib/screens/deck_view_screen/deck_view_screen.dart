import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:mtg_slo/screens/results_screen/results.dart';
import 'package:provider/provider.dart';

import 'package:mtg_slo/deck.dart';
import 'package:mtg_slo/deck_states.dart';
import 'package:mtg_slo/screens/deck_view_screen/card_view.dart';
import '../../card.dart';
import '../../global_states.dart';
import 'image_popup.dart';

class DeckViewScreen extends StatefulWidget {
  List<CardView> _cardViews = new List<CardView>();
  List<String> _existingCards = new List<String>();
  List<String> _existingLinks = new List<String>();


  @override
  _DeckViewScreenState createState() => _DeckViewScreenState();
}

class _DeckViewScreenState extends State<DeckViewScreen> {

  Future getCards(Deck deck) async {

    /*deck.getCards.forEach((card) {
      if(!widget._existingCards.containsKey(element)) {
        widget._existingCards[card] = 1;
      } else {

      }
    })*/

    var noDupes = deck.getCards.toSet().toList();

    for (var i=0; i<noDupes.length; i++) {
      widget._cardViews.add(CardView(noDupes[i]));
      widget._existingCards.add(noDupes[i].getCardName);
      widget._existingLinks.add(noDupes[i].getImagePath);
      }

    //print(widget._existingCards);
  }

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
    final globalStates = Provider.of<GlobalStates>(context);
    final deckStates = Provider.of<DeckStates>(context);
    final results = Provider.of<Results>(context);
    print(deckStates.decks[0].toJson());
    getCards(deckStates.decks[0]);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Text Entry",
            style: TextStyle(
              color: Color(0xffFFF8E8),
              fontSize: 25.0,
            )
          )
        ),
      ),
      body: new ListView.builder(
        shrinkWrap: true,
        itemCount: widget._cardViews == null ? 0 : widget._cardViews.length,
        itemBuilder: (BuildContext context, int index) {
          final cardView = widget._cardViews[index];

          return new GestureDetector(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) => ImagePopup(index, widget._existingLinks)
              );
            },
              child: new Dismissible(
                key: Key(cardView.getCardName),
                onDismissed: (direction) {
                  setState(() {
                    widget._cardViews.removeAt(index);
                  });

                  Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Card removed.")));
                },
                child: new Card(
                  semanticContainer: true,

                  child: widget._cardViews[index],
                )
              )
          );
        }

      ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () async {
        var tuple = await results.parseJson(deckStates.decks[0]);
        String tupleString = await tuple.getString();
        print(tupleString);
        tupleString = tupleString.substring(tupleString.lastIndexOf('['), tupleString.length);
        print("tupleString = $tupleString");
        var list = json.decode(tupleString);
        print("LIST = $list");
        globalStates.setTupleFromPython(list);
        globalStates.setResults();
        // deckStates.clear();
        Navigator.pushNamed(context, '/results');
      },
      backgroundColor: Color(0xff990d35),
      label: Text('Next'),
      icon: Icon(Icons.arrow_forward),
    )
    /*ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            //getCards(oldIndex, newIndex);
          });
          children: [
            for (final card in widget._cardViews) {
              ListTile(
                key: ValueKey(card),
                title: Text(),
              ),
            },
          ],
        }*/
        //children: widget._cardViews
      );
  }
}