import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mtg_slo/card.dart';

class TextEntryProcessing extends ChangeNotifier {

  String searchPrefix = "https://api.scryfall.com/cards/named?fuzzy=";

  List<String> processText(String boxText) {

    var textLines = boxText.split('\n');
    var finalCards = List<String>();
    for (var line in textLines) {
      var numCheck = line.split(' ');
      String num = numCheck[0];

      /* Magic Online Standard deck entry */
      if (int.tryParse(num) is int) {
        numCheck.removeAt(0);

        // if (numCheck.join())

        for (int i = 0; i < int.tryParse(num); i++) {
          finalCards.add(searchPrefix + numCheck.join('+'));
        }
        var cardName = numCheck.join();
      }
      /* Computer vision? */
      else
        break;
    }
    print(finalCards);
    return finalCards;
  }

  Future<MTGCard> fetchCards(String cardLink) async {
    final response = await http.get(cardLink);

    if (response.statusCode == 200) {
      return MTGCard.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load card');
    }
  }
}