import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mtg_slo/deck_states.dart';

// This screen is stateful in order to properly check permissions. Stateful
// screens/widgets are useful for updating information pertinent to one screen
// only.

class InputSelectionScreen extends StatefulWidget {
  @override
  _InputSelectionState createState() => _InputSelectionState();
}

class _InputSelectionState extends State<InputSelectionScreen> {
  PermissionStatus _status;


  @override
  void initState() {
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.camera)
    .then(_updateStatus);
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.camera]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.camera];
    if (status != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    } else {
      _updateStatus(status);
      Navigator.pushNamed(context, '/camera');
    }
  }


  @override
  Widget build(BuildContext context) {
    final deckStates = Provider.of<DeckStates>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff990d35),
        title: RichText(
            text: TextSpan(
                text: "MTG Deck Tuner",
                style: TextStyle(
                  color: Color(0xffFFF8E8), fontSize: 20.0,
                )
            )
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 125),
            Text("Select an input method",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 50.0,
              ),
            ),
            SizedBox(height: 125),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Color(0xff990d35),
                  onPressed: () {
                    deckStates.clear(); // TODO: maybe move this to clear only when the deck's color identity changes?
                    Navigator.pushNamed(context, '/mana');
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Mana Cost Entry",
                          style: TextStyle(
                            color: Color(0xFFFFF8E8), fontSize: 30.0,
                          )
                      )
                  ),
                ),
              ),
            ),
            //SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Color(0xff990d35),
                  onPressed: () {
                    deckStates.clear();
                    Navigator.pushNamed(context, '/text');
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Deck List Entry",
                          style: TextStyle(
                            color: Color(0xFFFFF8E8), fontSize: 30.0,
                          )
                      )
                  ),
                ),
              ),
            ),
            //SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Color(0xff990d35),
                  onPressed: () {
                    _askPermission(); // TODO: go to camera screen when permission is accepted
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Camera Entry",
                          style: TextStyle(
                            color: Color(0xFFFFF8E8), fontSize: 30.0,
                          )
                      )
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
          ]
      ),
    );
  }
}