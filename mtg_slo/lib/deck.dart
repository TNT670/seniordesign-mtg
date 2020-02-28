import 'package:mtg_slo/card.dart';

class Deck {
  String name, identity;
  List<MTGCard> cards = List();

  Deck(this.name);

  void addCard(MTGCard card) {
    cards.add(card);
  }
}