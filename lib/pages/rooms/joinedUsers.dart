import 'package:doubtbin/pages/rooms/userList.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/model/user.dart';
import 'package:provider/provider.dart';

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
    print(roomName);
    print(roomCode);
    print(description);
    return StreamProvider<List<MyUser>>.value(
      value: BinDatabase().users,
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
                    SizedBox(height: 40),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      // backgroundImage: AssetImage('/assets/google-logo.jpg'),
                    ),
                    title: Text(
                      'Wolf Gupta (Admin)',
                    ),
                    subtitle: Text('Chintu'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(child: UserList()),
          ],
        ),
        // body: BinDatabase(roomCode: roomCode).showAllMembers(roomCode),
      ),
    );
  }
}
