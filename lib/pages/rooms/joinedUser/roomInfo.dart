import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
}


class RoomInfo extends StatelessWidget {
  final key = new GlobalKey<ScaffoldState>();
  String roomCode,roomName,description;
  RoomInfo({this.roomCode,this.roomName,this.description});
  handleCopyCode(BuildContext context){
      Clipboard.setData(
        new ClipboardData(text: roomCode)
      );
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Copied to Clipboard'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
              key: RIKeys.riKey1,
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 30.0, 24.0, 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      roomName,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text("Joining Code : "),
                    SizedBox(height:5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex:5,
                          child: Text(
                            roomCode,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Flexible(
                          flex:1,
                          child: GestureDetector(
                            child: Icon(Icons.content_copy),
                            onTap: () {
                              handleCopyCode(context);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                  ],
                ),
              ),
            );
  }
}