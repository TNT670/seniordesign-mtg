import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';

import 'package:mtg_slo/deck.dart';
import 'package:mtg_slo/screens/mana_selection_screen/mana_icon.dart';
import 'package:mtg_slo/mana_display.dart';
import 'package:mtg_slo/result_display.dart';
import 'package:tuple/tuple.dart';

class GlobalStates extends ChangeNotifier {
  var colorMap = {"W": 0, "U": 1, "B": 2, "R": 3, "G": 4};

  String _symbol = "";  // temp
  String _code = "";  // string of chars representing color identity
  String _identity = "";  // title of identity
  String _format = "";  // the format the player is utilizing
  Tuple5<int, int, int, int, int> _results;
  List<ManaDisplay> manaDisplays = List();
  List<ResultDisplay> resultDisplays = List();
  List<String> _identities = List();
  List<Deck> _decks = List();
  File _image;

  Future getIdentities() async {  // returns Future so it can be awaited (no return statement necessary)
    String body;
    body = _format.contains("Standard") ?
      await rootBundle.loadString('assets/docs/identities_standard.txt') :
      await rootBundle.loadString('assets/docs/identities_commander.txt');
    LineSplitter ls = new LineSplitter();
    _identities = ls.convert(body);
  }

  void setCode(ManaIcon manaIcon) {
    // manaIcon.assetPath.length - 5 always refers to the symbol
    // mono color file names will be in the format "B.svg".
    // So the length of the file name - 5 will always return
    // the needed symbol.
    _symbol = manaIcon.assetPath[manaIcon.assetPath.length - 5];
    if(!_code.contains(_symbol)) {
      _code += _symbol;
    }
    else {
      _code = _code.replaceAll(RegExp(_symbol), '');
    }

    String sortedCode = "";
    // ensures WUBRG order
    if(_code.contains('W'))
      sortedCode += 'W';
    if(_code.contains('U'))
      sortedCode += 'U';
    if(_code.contains('B'))
      sortedCode += 'B';
    if(_code.contains('R'))
      sortedCode += 'R';
    if(_code.contains('G'))
      sortedCode += 'G';
    _code = sortedCode;
    setDisplays();
  }

  void setDisplays() {
    manaDisplays.clear();
    // _.code is the color identity
    for (int i=0; i<_code.length; i++) {
      manaDisplays.add(ManaDisplay('assets/icons/'+_code[i]+'.svg'));
    }
    setIdentity();
  }

  void setResults() {
    resultDisplays.clear();
    // remove the _results test set
    _results = Tuple5(0,0,0,0,0);
    List resultList = _results.toList();
    for (int i = 0; i < manaDisplays.length; i++) {
        var landCount = resultList[colorMap[manaDisplays[i].getAssetPath[manaDisplays[i].getAssetPath.length - 5]]];
        resultDisplays.add(ResultDisplay(manaDisplays[i], landCount));
      }
  }

  void setIdentity() {
    _identity = "";
    bool flag;

    // _identities is a list of all color identities.
    // This list is generated in getIdentities()
    for (int i=0; i<_identities.length; i++) {
      flag = true;
      for (int j=0; j<_code.length; j++) {
        if (!_identities[i].substring(0, _identities[i].indexOf('-')).contains(_code[j])) {
          flag = false;
        }
      }
      if (flag == true && _code.length != 0) {
        _identity = _identities[i].substring(_identities[i].indexOf('-')+1);
        break;
      }
    }
    notifyListeners();  // update widgets now that code, displays and identity have been changed
  }

  void identityError() {
    _identity = "Must select a color identity.";
    notifyListeners();
  }

  double getOpacity(ManaIcon manaIcon) {
    _symbol = manaIcon.assetPath[manaIcon.assetPath.length - 5];
    if(_code.contains(_symbol))
      return 0;
    else
      return 0.75;
  }

  void setFormat(String format) async {
    _format = format;
    await getIdentities();
    setDisplays();
  }

  void setImage(File image) {
    _image = image;
    print("image saved to global_states.dart");
  }

  String get getCode => _code;
  String get getIdentity => _identity;
  String get getFormat => _format;
  List<ManaDisplay> get getDisplays => manaDisplays;
  List<ResultDisplay> get getResultDisplays => resultDisplays;
  File get getImage => _image;
}