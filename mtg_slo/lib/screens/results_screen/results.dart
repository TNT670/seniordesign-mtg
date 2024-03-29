import 'package:flutter/material.dart';
import 'package:starflut/starflut.dart';
import 'dart:convert';  // jsonEncode
import 'package:tuple/tuple.dart';

import 'package:mtg_slo/deck.dart';

class Results extends ChangeNotifier {

  dynamic _python;

  Results() {
    testCallPython();
  }

  Future<void> testCallPython() async {
    StarCoreFactory starcore = await Starflut.getFactory();
    StarServiceClass Service = await starcore.initSimple(
        "test", "123", 0, 0, []);
    await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async {
          // print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
    StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];

    /*---script python--*/
    bool isAndroid = await Starflut.isAndroid();
    if (isAndroid == true) {
      String libraryDir = await Starflut.getNativeLibraryDir();
      String docPath = await Starflut.getDocumentPath();
      if (libraryDir.indexOf("arm64") > 0) {
        Starflut.unzipFromAssets("lib-dynload-arm64.zip", docPath, true);
      } else if (libraryDir.indexOf("x86_64") > 0) {
        Starflut.unzipFromAssets("lib-dynload-x86_64.zip", docPath, true);
      } else if (libraryDir.indexOf("arm") > 0) {
        Starflut.unzipFromAssets("lib-dynload-armeabi.zip", docPath, true);
      } else { //x86
        Starflut.unzipFromAssets("lib-dynload-x86.zip", docPath, true);
      }
      await Starflut.copyFileFromAssets(
          "python3.6.zip", "flutter_assets/backend", null); //desRelatePath must be null

      /* load backend python files pt. 1 */
      await Starflut.copyFileFromAssets(
          "parse_json.py", "flutter_assets/backend", null);
      await Starflut.copyFileFromAssets(
          "hypergeo.py", "flutter_assets/backend", null);
      await Starflut.copyFileFromAssets(
          "deckmath.py", "flutter_assets/backend", null);
      await Starflut.copyFileFromAssets(
          "test.py", "flutter_assets/backend", null);
      await Starflut.copyFileFromAssets(
          "testData.py", "flutter_assets/backend", null);
      await Starflut.copyFileFromAssets(
          "land.py", "flutter_assets/backend", null);
    }

    String docPath = await Starflut.getDocumentPath();
    print("docPath = $docPath");

    String resPath = await Starflut.getResourcePath();
    print("resPath = $resPath");

    dynamic rr1 = await SrvGroup.initRaw("python36", Service);
    print("initRaw = $rr1");

    /* load backend python scripts pt 2 */
    var Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/hypergeo.py", false);
    print("hypergeo= $Result");

    Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/deckmath.py", false);
    print("deckmath= $Result");

    Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/testData.py", false);
    print("structs= $Result");

    Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/land.py", false);
    print("land= $Result");

    Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/parse_json.py", false);
    print("parse_json= $Result");

    Result = await SrvGroup.loadRawModule(
        "python", "", resPath + "/test.py", false);
    print("main= $Result");

    _python = await Service.importRawContext("python", "", false, "");
    print("python = " + await _python.getString());

    // int retobj = await python.call("multi", [5, 10]);
    // print(retobj);
  }

  Future<String> install(String package) async {
    return await _python.call("install", [package]);
  }

  Future<StarObjectClass> parseJson(Deck deck) async {
    return await _python.call("parse_json", [jsonEncode(deck)]);
  }
}