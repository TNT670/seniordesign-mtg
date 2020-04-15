import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:mtg_slo/screens/results_screen/results.dart';
import 'package:mtg_slo/global_states.dart';
import 'package:mtg_slo/deck_states.dart';

class ManualSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalStates = Provider.of<GlobalStates>(context);
    final deckStates = Provider.of<DeckStates>(context);
    final weightController = deckStates.weightController;
    final results = Provider.of<Results>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Card: " + deckStates.getCurrentCardCount.toString() + "/" + deckStates.getCardCount(globalStates.getFormat).toString(),
                style: TextStyle(
                  fontFamily: 'Magic',
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 8,
              child: Wrap(
                spacing: 40.0,
                runSpacing: 10.0,
                children: deckStates.getBasicButtons,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ), // cheaty padding
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 5.0),
                ),
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment(0.0, 0.0),
                      child: Wrap(
                        spacing: 40.0,
                        runSpacing: 10.0,
                        children: deckStates.getAdvancedButtons,
                      ),
                    ),
                  ]
                ),
              ),
            ),
            Flexible( // more cheaty padding
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: RichText(
                      text: TextSpan(
                        text: "Copies ",
                        style: TextStyle(
                          fontFamily: 'Magic', fontSize: 25.0,
                          color: Colors.black, fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: weightController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        border: OutlineInputBorder()
                      )
                    )
                  )
                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Wrap(
                children: deckStates.getManaCost
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Colors.deepPurpleAccent,
                    disabledColor: Colors.grey,
                    padding: EdgeInsets.all(8.0),

                    onPressed: deckStates.getCurrentCardCount == 1 ?
                      null :
                      () => deckStates.previousCard(),

                    child: RichText(
                      text: TextSpan(
                        text: "Previous Card",
                        style: TextStyle(
                          fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                  ),
                  FlatButton(
                    color: Colors.deepPurple,
                    disabledColor: Colors.grey,
                    padding: EdgeInsets.all(8.0),

                    onPressed: deckStates.getCurrentCardCount == deckStates.getCardCount(globalStates.getFormat) ?
                      null :
                      () => deckStates.nextCard(deckStates.getCostCode),

                    child: RichText(
                      text: TextSpan(
                        text: "Next Card",
                        style: TextStyle(
                          fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: (deckStates.getCurrentCardCount != 1),
        child: FloatingActionButton.extended(
          onPressed: () async {
            // TODO: pass deck to hypergeometric script
            // String json = jsonEncode(deckStates.getDeck);
            // print(json);
            var tuple = await results.parseJson(deckStates.getDeck);
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
          label: Text('Next'),
          icon: Icon(Icons.arrow_forward),
        )
      )
    );
  }
}