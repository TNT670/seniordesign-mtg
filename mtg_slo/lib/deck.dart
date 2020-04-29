import 'package:mtg_slo/card.dart';
import 'package:mtg_slo/global_states.dart';

class Deck {
  String deckName, identity, format;
  List<MTGCard> cards = List<MTGCard>();

  Deck(this.deckName);

  void addCard(MTGCard card) {
    cards.add(card);
  }

  void clear() {
    cards.clear();
  }

  void setFormat(String f) {
    format = f;
  }

  void setIdentity(String code) {
    identity = code;
  }

  Map<String, dynamic> toJson() {
    List<Map> cards =
        this.cards != null ? this.cards.map((i) => i.toJson()).toList() : null;
    return {
      'format': format,
      'deckName': deckName,
      'identity': identity,
      'cards': cards,
    };
  }

  List<MTGCard> get getCards => cards;
  int get length => this.cards.length;
}