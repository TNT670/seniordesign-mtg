import 'package:mtg_slo/card.dart';

class Deck {
  String deckName, identity;
  List<MTGCard> cards = List();

  Deck(this.deckName);

  void addCard(MTGCard card) {
    cards.add(card);
  }

  void clear() {
    cards.clear();
  }

  void setIdentity(String code) {
    identity = code;
  }

  Map<String, dynamic> toJson() {
    List<Map> cards =
        this.cards != null ? this.cards.map((i) => i.toJson()).toList() : null;
    return {
      'deckName': deckName,
      'identity': identity,
      'cards': cards,
    };
  }

  List<MTGCard> get getCards => cards;
}