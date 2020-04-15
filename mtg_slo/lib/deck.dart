import 'package:mtg_slo/card.dart';
import 'package:mtg_slo/global_states.dart';

class Deck {
  GlobalStates globalStates;
  String deckName, identity, format;
  List<MTGCard> cards = List();

  Deck(this.deckName);

  void addCard(MTGCard card) {
    cards.add(card);
  }

  void clear() {
    cards.clear();
  }

  void setFormat(String format) {
    format = format;
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
}