import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'mana_icon.dart';

class CodeState extends ChangeNotifier {
  String _code = "";
  String _symbol = "";
  String _identity = "";
  List<ManaIcon> manaIcons = List();
  List<String> _identities = ['a', 'b', 'c'];

  CodeState() {
    print(_identities);
    getIdentities();

  }

  void getIdentities() async {
    String body = await rootBundle.loadString('assets/docs/identities_standard.txt');
    LineSplitter ls = new LineSplitter();
    _identities = ls.convert(body);
    //_identities = body.split('\\n').map((String text) => Text(text)).toList();
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
    manaIcons = setIcons();

    notifyListeners();
  }

  List<ManaIcon> setIcons() {
    manaIcons.clear();
    for (int i=0; i<_code.length; i++) {
      manaIcons.add(ManaIcon('assets/icons/'+_code[i]+'.svg'));
    }
    setIdentity();
    return manaIcons;
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

  String get getCode => _code;
  String get getIdentity => _identity;
}