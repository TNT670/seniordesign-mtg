import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mtg_slo/global_states.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;

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
    final globalStates = Provider.of<GlobalStates>(context);
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
                          flex: 1,
                          child: new Container(
                              margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                              child: new FlatButton(
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    getImageFromCamera();
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
                            onPressed: () {
                              getImageFromGallery();
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
              : Image.file(_image),
        ),
        floatingActionButton: _image != null
            ? FloatingActionButton.extended(
                onPressed: () {
                  globalStates.setImage(_image);
                  Navigator.pushNamed(context, '/results');
                },
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward)
            )
            : null
    );
  }
}
