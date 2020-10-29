import 'package:doubtbin/pages/rooms/addNewPost/newPost.dart';
import 'package:doubtbin/pages/rooms/postList.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDashboard extends StatefulWidget {
  final bool firstTime;
  final String roomCode;
  final String roomName;

  RoomDashboard({this.firstTime,  this.roomCode,this.roomName});

  @override
  _RoomDashboardState createState() =>
      _RoomDashboardState(firstTime: firstTime,roomCode: roomCode,roomName:roomName);
}

class _RoomDashboardState extends State<RoomDashboard> {
  final key = new GlobalKey<ScaffoldState>();
  bool firstTime;
  String roomCode;
  String roomName;

  _RoomDashboardState({this.firstTime, this.roomCode,this.roomName});

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
                        Flexible(child: Text(roomCode,softWrap: true,)),
                        GestureDetector(
                          child: Icon(Icons.content_copy),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: roomCode));
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
                    ]
                  )
              );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar(
        roomName,
      ),
      body: BinDatabase(roomCode:roomCode).showAllPost(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost(roomCode: roomCode,roomName:roomName)));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
