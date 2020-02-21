import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'mana_icon.dart';
import 'package:mtg_slo/mana_display.dart';

class CodeState extends ChangeNotifier {
  String _code = "";
  String _symbol = "";
  String _identity = "";
  List<ManaDisplay> manaDisplays = List();
  List<String> _identities = List();

  CodeState() {
    getIdentities();
  }

  void getIdentities() async {
    String body = await rootBundle.loadString('assets/docs/identities_standard.txt');
    LineSplitter ls = new LineSplitter();
    _identities = ls.convert(body);
    print(_identities);
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
    if (manaIcon.pressedStatus)
      return 0;
    else
      return 0.75;
  }

  String get getCode => _code;
  String get getIdentity => _identity;
}