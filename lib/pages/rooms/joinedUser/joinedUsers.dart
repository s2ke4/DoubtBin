import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/joinedUser/exitButton.dart';
import 'package:doubtbin/pages/rooms/joinedUser/roomInfo.dart';
import 'package:doubtbin/pages/rooms/joinedUser/userTile.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class JoinedUsers extends StatefulWidget {
  final String roomCode;
  final String roomName;
  final String description;
  List<dynamic> domains;
  Function updateInfo2;
  Bin bin;
  JoinedUsers(
      {this.roomCode,
      this.roomName,
      this.description,
      this.domains,
      this.bin,
      this.updateInfo2});

  @override
  _JoinedUsersState createState() => _JoinedUsersState(
      roomCode: roomCode,
      roomName: roomName,
      description: description,
      domains: domains,
      bin: bin,
      updateInfo2: updateInfo2);
}

class _JoinedUsersState extends State<JoinedUsers> {
  String roomCode;
  String roomName;
  String description;
  List<dynamic> domains;
  Bin bin;
  Function updateInfo2;
  String oid;
  bool isLoading = true;
  DocumentSnapshot docSnap;
  _JoinedUsersState(
      {this.roomCode,
      this.roomName,
      this.description,
      this.domains,
      this.bin,
      this.updateInfo2}) {
    getDetail();
  }
  void getDetail() async {
    DocumentSnapshot coll = await binCollection.doc(roomCode).get();
    setState(() => oid = coll.data()['ownerId']);
    DocumentSnapshot docsnap = await userCollection.doc(oid).get();
    setState(() => docSnap = docsnap);
    setState(() => isLoading = false);
    print(domains);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar("Joined Users"),
        body: ListView(
          children: [
            isLoading
                ? Loading()
                : RoomInfo(
                    updateInfo2: updateInfo2,
                    bin: bin,
                    roomCode: bin.roomId,
                    roomName: bin.binName,
                    description: bin.description,
                    ownerId: docSnap.id,
                    domains: bin.domain),
            ExitButton(code: roomCode, uid: currentUser.uid),
            isLoading
                ? Loading()
                : UserTile(
                    user: MyUser(
                        uid: docSnap.id,
                        displayName: docSnap.data()['displayName'] + " (Admin)",
                        email: docSnap.data()['email'],
                        photoURL: docSnap.data()['circleAvatar'],
                        userName: docSnap.data()['userName']),
                    ownerId: oid,
                    code: roomCode,
                  ),
            isLoading
                ? Loading()
                : Container(
                    child: BinDatabase().showAllMembers(roomCode, oid),
                  )
          ],
        ),
      ),
    );
  }
}
