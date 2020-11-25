import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/customAppBar.dart';
import 'package:flutter/material.dart';

Bin currentBin;

class JoinedUsers extends StatefulWidget {
  final String roomCode;
  final String roomName;
  final String description;
  JoinedUsers({this.roomCode, this.roomName, this.description});

  @override
  _JoinedUsersState createState() => _JoinedUsersState(
      roomCode: roomCode, roomName: roomName, description: description);
}

class _JoinedUsersState extends State<JoinedUsers> { 
  String roomCode;
  String roomName;
  String description;
  _JoinedUsersState({this.roomCode, this.roomName, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(title: Text('Joined Users')),
        ),
        body: ListView(
          children: [
            Card(
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
                    Text(
                      'Joining Code : $roomCode',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: BinDatabase().showAllMembers(roomCode),
            )
          ],
        ),
        // body: BinDatabase(roomCode: roomCode).showAllMembers(roomCode),
      ),
    );
  }
}
