import 'package:flutter/material.dart';

import 'package:mtg_slo/card.dart';
import 'package:mtg_slo/deck.dart';
import 'package:mtg_slo/screens/manual_selection_screen/mana_button.dart';
import 'package:mtg_slo/screens/manual_selection_screen/mana_button_deselect.dart';
import 'package:mtg_slo/global_states.dart';

class DeckStates extends ChangeNotifier {
  GlobalStates globalStates;
  Deck deck = Deck("tempName");
  List<Deck> decks = List<Deck>();
  List<ManaButton> basicButtons = List(), advancedButtons = List();
  List<ManaButtonDeselect> manaCost = List();
  String _code, _costCode="";
  int _count = 1, _totalCount;

  final weightController = TextEditingController();

  final List<String> dualCodes = [
    'BG', 'BR', 'GU', 'GW', 'RG', 'RW', 'UB', 'UR', 'WB', 'WU'
  ];

  final List<String> phyrexianCodes = [
    'WP', 'GP', 'UP', 'RP', 'BP'
  ];

  final List<String> otherCodes = [
    'X', 'C'
  ];

  final List<String> numCodes = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
    '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'
  ];

  void clear() {
    manaCost.clear();
    _costCode = "";
    _count = 1;
    deck.clear();
    notifyListeners();
  }

  void softClear() {
    manaCost.clear();
    _costCode = "";
  }

  void setFormat(String format) {
    deck.setFormat(format);
  }

  void setCode(String code) {
    _code = code;
    _costCode = "";
    deck.setIdentity(code);
    setBasicButtons();
    setAdvancedButtons();
    weightController.text = '1';
    notifyListeners();
  }

  void setBasicButtons() {
    basicButtons.clear();
    basicButtons.add(ManaButton('assets/icons/0.svg', '0'));
    for (int i=0; i<_code.length; i++) {
      basicButtons.add(ManaButton('assets/icons/' + _code[i] + '.svg', _code[i]));
    }
  }

  void setAdvancedButtons() {
    int count;

    advancedButtons.clear();

    advancedButtons.add(ManaButton('assets/icons/X.svg', 'X'));
    advancedButtons.add(ManaButton('assets/icons/C.svg', 'C'));


    for (int i=0; i<dualCodes.length; i++) {
      count = 0;
      for (int j=0; j<_code.length; j++) {
        if (dualCodes[i].contains(_code[j])) {
          count++;
        }
      }
      if (count == 2)
        advancedButtons.add(ManaButton('assets/icons/' + dualCodes[i] + '.svg', dualCodes[i]));
    }

    for (int i=0; i<phyrexianCodes.length; i++) {
      for (int j=0; j<_code.length; j++) {
        if (phyrexianCodes[i].contains(_code[j])) {
          advancedButtons.add(ManaButton('assets/icons/' + phyrexianCodes[i] + '.svg', phyrexianCodes[i]));
        }
      }
    }
  }

  int getCardCount(String format) {
    if (format == "Standard 40")
      _totalCount = 40;
    else if (format == "Standard 60")
      _totalCount = 60;
    else
      _totalCount = 100;
    // deck = List(_totalCount);
    return _totalCount;
  }

  void setMana() {
    if (new RegExp(r"[^{\}A-Z]+(?=})").hasMatch(_costCode))
      manaCost.add(ManaButtonDeselect('assets/icons/' + new RegExp(r"[^{\}A-Z]+(?=})").stringMatch(_costCode) + '.svg'));

    for (int i=0; i<otherCodes.length; i++) {
      for (int j=0; j<new RegExp(r'\b' + otherCodes[i] + r'\b').allMatches(_costCode).length; j++) {
        manaCost.add(ManaButtonDeselect('assets/icons/' + otherCodes[i] + '.svg'));
      }
    }

    for (int i=0; i<dualCodes.length; i++) {
      for (int j=0; j<new RegExp(r'\b' + dualCodes[i] + r'\b').allMatches(_costCode).length; j++) {
        manaCost.add(ManaButtonDeselect('assets/icons/' + dualCodes[i] + '.svg'));
      }
    }

    for (int i=0; i<new RegExp(r'\bW\b').allMatches(_costCode).length; i++)
      manaCost.add(ManaButtonDeselect('assets/icons/W.svg'));
    for (int i=0; i<new RegExp(r'\bU\b').allMatches(_costCode).length; i++)
      manaCost.add(ManaButtonDeselect('assets/icons/U.svg'));
    for (int i=0; i<new RegExp(r'\bB\b').allMatches(_costCode).length; i++)
      manaCost.add(ManaButtonDeselect('assets/icons/B.svg'));
    for (int i=0; i<new RegExp(r'\bR\b').allMatches(_costCode).length; i++)
      manaCost.add(ManaButtonDeselect('assets/icons/R.svg'));
    for (int i=0; i<new RegExp(r'\bG\b').allMatches(_costCode).length; i++)
      manaCost.add(ManaButtonDeselect('assets/icons/G.svg'));

    for (int i=0; i<phyrexianCodes.length; i++) {
      for (int j=0; j<new RegExp(r'\b' + phyrexianCodes[i] + r'\b').allMatches(_costCode).length; j++) {
        manaCost.add(ManaButtonDeselect('assets/icons/' + phyrexianCodes[i] + '.svg'));
      }
    }
  }

  void addMana(String code) {
    manaCost.clear();

    if (new RegExp(r"[^{\}A-Z]+(?=})").hasMatch(_costCode) && int.tryParse(code) is int)
      _costCode = _costCode.replaceAll(new RegExp(r"[^{\}A-Z]+(?=})"),
          (int.parse(new RegExp(r"[^{\}A-Z]+(?=})").stringMatch(_costCode)) + 1).toString());
    else
      _costCode += '{' + code + '}';

    if (otherCodes[0].contains(code)) {
      _costCode = _costCode.replaceAll(new RegExp(r'[^{\}A-WY-Z]+(?=})'), '');
    }

    if (numCodes.contains(code)) {
      _costCode = _costCode.replaceAll(new RegExp(r'[^{\}A-WY-Z0-9]+(?=})'), '');
    }

    print(_costCode);

    setMana();

    notifyListeners();
  }

  void decMana(String code) {
    manaCost.clear();

    if (numCodes.contains(code))
      _costCode = _costCode.replaceFirst(new RegExp(r'0( )*'), '');
    else
      _costCode = _costCode.replaceFirst(new RegExp(r'\b' + code + r'( )*\b'), '');

    print(_costCode);

    setMana();
    if (manaCost.length == 0)
      _costCode = "";

    notifyListeners();
  }

  bool addCard(String manaCost) {
    if (_count < _totalCount && manaCost != "") {
      for (int i=0; i<int.parse(weightController.text); i++) {
        deck.addCard(MTGCard.manaCost(manaCost));
      }
      _count += int.parse(weightController.text);
      weightController.text = '1';
      softClear();
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  bool nextCard(String manaCost) {
    if (deck.getCards.length >= (_count)) {
      softClear();
      deck.getCards[_count-1].manaCost = manaCost;
      _count += 1;
      if (_count <= deck.getCards.length)
        _costCode = deck.getCards[_count-1].manaCost;
      setMana();
      notifyListeners();
      return true;
    }
    else {
      return addCard(manaCost);
    }
  }

  void previousCard() {
    _count -= 1;
    softClear();
    _costCode = deck.getCards[_count-1].manaCost;

    setMana();
    notifyListeners();
  }

  int get getCurrentCardCount => _count;
  String get getCostCode => _costCode;
  List<ManaButton> get getBasicButtons => basicButtons;
  List<ManaButton> get getAdvancedButtons => advancedButtons;
  List<ManaButtonDeselect> get getManaCost => manaCost;
  Deck get getDeck => deck;
}