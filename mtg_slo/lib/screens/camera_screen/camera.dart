import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mtg_slo/screens/text_entry_screen/text_entry_processing.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../card.dart';
import '../../deck.dart';
import '../../deck_states.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;
  String _extractText;
  Map<String, dynamic> _allCards = Map<String, dynamic>();
  List<String> _allMatches = List<String>();

  @override
  void initState() {
    super.initState();
  }

  /*Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: FlutterMobileVision.CAMERA_BACK,
      );


    } on Exception {
      texts.add(OcrText("Failed to recognize text."));
    }

    setState(() => _extractText = texts);
  }*/

  Future<Map<String, dynamic>> fetchCardNames(String link) async {
    final response = await http.get(link);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load card');
    }
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  Future<void> readImage(File _image) async {
    String extractText;

    final Directory directory = await getTemporaryDirectory();
    final String imagePath = join(
      directory.path,
      "tmp_1.jpg",
    );

    try {
      final Directory directory = await getTemporaryDirectory();
      final Uint8List bytes = await _readFileByte(_image.path);
      await File(imagePath).writeAsBytes(bytes);

      extractText = await TesseractOcr.extractText(imagePath, language: "eng");
    } on PlatformException {
      extractText = 'Failed';
    }

    setState(() {
      _extractText = extractText;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textEntryProcessing = Provider.of<TextEntryProcessing>(context);
    final deckStates = Provider.of<DeckStates>(context);
    return Scaffold(
        appBar: AppBar(
            title: RichText(
                text: TextSpan(
                    text: "Computer Vision",
                    style: TextStyle(
                        fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                    )
                )
            ),
        ),
        body: Center(
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text("Detected Text: $_extractText\n")
                        )
                      ),
                      Expanded(
                          flex: 1,
                          child: new Container(
                              margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                              child: new FlatButton(
                                  color: Colors.blueAccent,
                                  onPressed: () async {
                                    // getImageFromCamera();
                                  },
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Camera",
                                          style: TextStyle(
                                            fontFamily: 'Magic', color: Colors.black87,
                                            fontSize: 40.0, fontWeight: FontWeight.bold,
                                          )
                                      )
                                  ),
                              ),
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          child: new FlatButton(
                            color: Colors.blueAccent,
                            onPressed: () async {
                              await getImageFromGallery();
                              readImage(_image);
                              print(_image.runtimeType.toString());
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: "Gallery",
                                    style: TextStyle(
                                      fontFamily: 'Magic', color: Colors.black87,
                                      fontSize: 40.0, fontWeight: FontWeight.bold,
                                    )
                                )
                            ),
                          ),
                        ),
                      ),
                  ],
              )
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text("Detected Text: $_extractText\n")
                  )
                ),
                Expanded(
                  flex: 6,
                  child: Image.file(_image),
                )
              ],
          ),
        ),
        floatingActionButton: _image != null
            ? FloatingActionButton.extended(
                onPressed: () async {
                  _allCards = await fetchCardNames("https://api.scryfall.com/catalog/card-names");
                  deckStates.setImage(_image);
                  print("*********\n*********************");

                  _allCards["data"].forEach((card) {
                    if (_extractText.contains(card))
                      _allMatches.add("https://api.scryfall.com/cards/named?fuzzy=" + card.replaceAll(' ', '+'));
                  });

                  var cardListObj = List<MTGCard>();
                  Deck cardListObjFinal = Deck("tempname");

                  for (var card in cardListObj) {
                    if (!card.getTypeLine.contains('Land'))
                      cardListObjFinal.addCard(card);
                  }

                  print(cardListObjFinal.length);

                  deckStates.decks.add(cardListObjFinal);

                  print(_allMatches);

                  print(_allCards["data"]);
                  Navigator.pushNamed(context, '/deck');
                },
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward)
            )
            : null
    );
  }
}
