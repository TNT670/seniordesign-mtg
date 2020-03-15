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
      // TODO: go to camera screen
    }
  }


  @override
  Widget build(BuildContext context) {
    final deckStates = Provider.of<DeckStates>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Select an input method",
                style: TextStyle(
                  fontFamily: 'Magic', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                )
            )
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  deckStates.clear(); // TODO: maybe move this to clear only when the deck's color identity changes?
                  Navigator.pushNamed(context, '/manual');
                },
                child: RichText(
                  text: TextSpan(
                    text: "Manual Entry",
                    style: TextStyle(
                      fontFamily: 'Magic', color: Colors.black87,
                      fontSize: 40.0, fontWeight: FontWeight.bold,
                    )
                  )
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.purpleAccent,
                onPressed: () {
                },
                child: RichText(
                    text: TextSpan(
                        text: "Deck Entry",
                        style: TextStyle(
                          fontFamily: 'Magic', color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold,
                        )
                    )
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.yellowAccent,
                onPressed: () {
                  _askPermission(); // TODO: go to camera screen when permission is accepted
                },
                child: RichText(
                    text: TextSpan(
                        text: "Camera",
                        style: TextStyle(
                          fontFamily: 'Magic', color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold,
                        )
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }
}