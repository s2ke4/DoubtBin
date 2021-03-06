import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/pages/rooms/joinedUser/joinedUsers.dart';
import 'package:doubtbin/pages/rooms/addNewPost/newPost.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDashboard extends StatefulWidget {
  final bool firstTime;
  final Bin bin;
  RoomDashboard({this.firstTime, this.bin});

  @override
  _RoomDashboardState createState() =>
      _RoomDashboardState(firstTime: firstTime, bin: bin);
}

class _RoomDashboardState extends State<RoomDashboard> {
  final key = new GlobalKey<ScaffoldState>();
  bool firstTime;
  Bin bin;
  _RoomDashboardState({this.firstTime, this.bin}) {}

  void updateInfo2(Bin bin) {
    setState(() {
      this.bin = bin;
    });
  }

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
                          bin.roomId,
                          softWrap: true,
                        )),
                        GestureDetector(
                          child: Icon(Icons.content_copy),
                          onTap: () {
                            Clipboard.setData(
                                new ClipboardData(text: bin.roomId));
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
          backgroundColor: Color(0xff007EF4),
          title: Text(bin.binName),
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
                              updateInfo2: updateInfo2,
                              bin: bin,
                            )));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: BinDatabase(roomCode: bin.roomId).showAllPost(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewPost(roomCode: bin.roomId, roomName: bin.binName)));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
