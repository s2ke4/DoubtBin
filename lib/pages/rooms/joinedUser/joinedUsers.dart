import 'package:cloud_firestore/cloud_firestore.dart';
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
  JoinedUsers({this.roomCode, this.roomName, this.description});

  @override
  _JoinedUsersState createState() => _JoinedUsersState(
      roomCode: roomCode, roomName: roomName, description: description);
}

class _JoinedUsersState extends State<JoinedUsers> { 
  String roomCode;
  String roomName;
  String description;
  String oid;
  bool isLoading = true;
  DocumentSnapshot docSnap;
  _JoinedUsersState({this.roomCode, this.roomName, this.description}){
    getDetail();
  }
  void getDetail()async{
    DocumentSnapshot coll = await binCollection.doc(roomCode).get();
    setState(()=>oid = coll.data()['ownerId']);
    DocumentSnapshot docsnap = await userCollection.doc(oid).get();
    setState(()=>docSnap = docsnap);
    setState(()=>isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar("Joined Users"),
        body:ListView(
          children: [
            RoomInfo(roomCode:roomCode,roomName:roomName,description:description),
            ExitButton(code:roomCode,uid:currentUser.uid),
            isLoading?Loading():UserTile(
              user: MyUser(
                  uid: docSnap.id,
                  displayName: docSnap.data()['displayName']+" (Admin)",
                  email: docSnap.data()['email'],
                  photoURL: docSnap.data()['circleAvatar'],
                  userName: docSnap.data()['userName']),
            ),
            isLoading?Loading():Container(
              child: BinDatabase().showAllMembers(roomCode,oid),
            )
          ],
        ),
      ),
    );
  }
}
