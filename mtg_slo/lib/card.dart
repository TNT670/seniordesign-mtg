class MTGCard {
  String cardName, manaCost, typeLine, imagePath;
  // String weight;

  MTGCard({this.cardName="", this.manaCost="", this.typeLine="", this.imagePath=""});
  MTGCard.manaCost(this.manaCost);
  MTGCard.all(this.cardName, this.manaCost, this.typeLine, this.imagePath);

  Map<String, dynamic> toJson() => {
    'name': cardName,
    'mana_cost': manaCost,
    'type_line': typeLine,
    'normal': imagePath,
  };

  factory MTGCard.fromJson(Map<String, dynamic> json) {
    return MTGCard(
      cardName: json['name'],
      manaCost: json['mana_cost'],
      typeLine: json['type_line'],
      imagePath: json['image_uris']['normal'],
    );
  }

  String get getCardName => cardName;
  String get getManaCost => manaCost;
  String get getTypeLine => typeLine;
  String get getImagePath => imagePath;
}