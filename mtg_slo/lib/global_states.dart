import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:mtg_slo/screens/mana_selection_screen/mana_icon.dart';
import 'package:mtg_slo/mana_display.dart';

class GlobalStates extends ChangeNotifier {
  String _symbol = "";  // temp
  String _code = "";  // string of chars representing color identity
  String _identity = "";  // title of identity
  String _format = "";  // the format the player is utilizing
  List<ManaDisplay> manaDisplays = List();
  List<String> _identities = List();

  void getIdentities() async {
    String body;
    if(_format.contains("Standard40") || _format.contains("Standard60"))
      body = await rootBundle.loadString('assets/docs/identities_standard.txt');
    else
      body = await rootBundle.loadString('assets/docs/identities_commander.txt');
    LineSplitter ls = new LineSplitter();
    _identities = ls.convert(body);
  }

  void setCode(ManaIcon manaIcon) {
    _symbol = manaIcon.assetPath[manaIcon.assetPath.length - 5];
    if(!_code.contains(_symbol)) {
      _code += _symbol;
    }
    else {
      _code = _code.replaceAll(RegExp(_symbol), '');
    }
    manaDisplays = setDisplays();

    notifyListeners();
  }

  List<ManaDisplay> setDisplays() {
    manaDisplays.clear();
    for (int i=0; i<_code.length; i++) {
      manaDisplays.add(ManaDisplay('assets/icons/'+_code[i]+'.svg'));
    }
    setIdentity();
    return manaDisplays;
  }

  void setIdentity() {
    _identity = "";
    bool flag;
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
  }

  double getOpacity(ManaIcon manaIcon) {
    _symbol = manaIcon.assetPath[manaIcon.assetPath.length - 5];
    if(_code.contains(_symbol))
      return 0;
    else
      return 0.75;
  }

  void setFormat(String format) {
    _format = format;
    getIdentities();
    setIdentity();
  }

  String get getCode => _code;
  String get getIdentity => _identity;
  String get getFormat => _format;
}