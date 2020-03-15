class MTGCard {
  String cardName, manaCost;
  // String weight;

  MTGCard(this.manaCost, {this.cardName=""});

  Map<String, dynamic> toJson() => {
    'cardName': cardName,
    'manaCost': manaCost,
  };
}