import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mtg_slo/card.dart';

class TextEntryProcessing extends ChangeNotifier {

  String searchPrefix = "https://api.scryfall.com/cards/named?fuzzy=";

  Map<String, int> processText(String boxText) {

    var textLines = boxText.split('\n');
    var finalCards = Map<String, int>();
    for (var line in textLines) {
      var numCheck = line.split(' ');
      String num = numCheck[0];

      /* Magic Online Standard deck entry */
      if (int.tryParse(num) is int) {
        numCheck.removeAt(0);

        // if (numCheck.join())

        finalCards[searchPrefix + numCheck.join('+')] = int.parse(num);
        var cardName = numCheck.join();
      }
      /* Computer vision? */
      else if (line == "Sideboard")
        break;
      else
        finalCards[searchPrefix + numCheck.join('+')] = 1;
    }
    print("******");
    print(finalCards);
    return finalCards;
  }

  Future<MTGCard> fetchCards(String cardLink, int cardNum) async {
    final response = await http.get(cardLink);

    print(cardLink);

    if (response.statusCode == 200) {
      var card = MTGCard.fromJson(json.decode(response.body));
      card.setCardCount(cardNum);
      return card;
    } else {
      await fetchCards(cardLink, cardNum);
      // throw Exception('Failed to load card');
    }
  }
}