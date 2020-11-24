import 'package:doubtbin/pages/rooms/joinedUsers.dart';
import 'package:doubtbin/pages/rooms/addNewPost/newPost.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDashboard extends StatefulWidget {
  final bool firstTime;
  final String roomCode;
  final String roomName;
  final String description;
  RoomDashboard(
      {this.firstTime, this.roomCode, this.roomName, this.description});

  @override
  _RoomDashboardState createState() => _RoomDashboardState(
      firstTime: firstTime,
      roomCode: roomCode,
      roomName: roomName,
      description: description);
}

class _RoomDashboardState extends State<RoomDashboard> {
  final key = new GlobalKey<ScaffoldState>();
  bool firstTime;
  String roomCode;
  String roomName;
  String description;

  _RoomDashboardState(
      {this.firstTime, this.roomCode, this.roomName, this.description});

  @override
  void initState() {
    super.initState();
    if (firstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        "Copy Below Code And share with other to invite them"),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          roomCode,
                          softWrap: true,
                        )),
                        GestureDetector(
                          child: Icon(Icons.content_copy),
                          onTap: () {
                            Clipboard.setData(
                                new ClipboardData(text: roomCode));
                            key.currentState.showSnackBar(new SnackBar(
                              content: new Text("Copied to Clipboard"),
                            ));
                            Future.delayed(Duration(seconds: 2), () {
                              key.currentState.hideCurrentSnackBar();
                            });
                          },
                        )
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: CustomAppBar(
        appBar: AppBar(
          title: Text(roomName),
          actions: [
            FlatButton.icon(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              label: Text(
                'Users',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JoinedUsers(
                              roomCode: roomCode,
                              roomName: roomName,
                              description: description,
                            )));
              },
            ),
          ],
        ),
        // onTap: () {
        //   print("opening the joined in user list.");
        // },
      ),
      body: BinDatabase(roomCode: roomCode).showAllPost(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewPost(roomCode: roomCode, roomName: roomName)));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
