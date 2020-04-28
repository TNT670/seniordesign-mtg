import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../card.dart';
import 'package:mtg_slo/screens/deck_view_screen/deck_view_screen.dart';
class ImagePopup extends StatefulWidget {

  NetworkImage _image;
  List<String> _existingLinks = new List<String>();
  int _index;

  ImagePopup(this._index, this._existingLinks);

  @override
  _ImagePopupState createState() => _ImagePopupState();
}

class _ImagePopupState extends State<ImagePopup> {

  @override
  void initState() {
    super.initState();
    widget._image = new NetworkImage(widget._existingLinks[widget._index]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: widget._image,
                fit: BoxFit.cover
              )
            )
        ),
          SizedBox.expand(
            child: new Opacity(opacity: 0.0,
              child: RaisedButton(
                onPressed: () => Navigator.pop(context),
            )
            )
          )
      ]
    );
  }


}