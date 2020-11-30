import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/pages/profile/editUsename.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:doubtbin/pages/home/home.dart';

class Profile extends StatefulWidget {

  String userId;
  Profile({this.userId});

  @override
  _ProfileState createState() => _ProfileState(userId: userId);
}

class _ProfileState extends State<Profile> {

  bool isLoading = true;
  MyUser profileUser;
  String userId;
  _ProfileState({this.userId}){
       _user();
    }

    Future<void> updateUserName()async{
      DocumentSnapshot userDoc = await userRef.doc(userId).get();
       setState(()=>profileUser = MyUser.creatingUser(userDoc));
    }

    Future<void> _user()async{
       DocumentSnapshot userDoc = await userRef.doc(userId).get();
       profileUser = MyUser.creatingUser(userDoc);
       setState(()=>isLoading = false);
    }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[400], Colors.white],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: appBar("Profile"),
        body: isLoading?Loading():Container(
          child: ListView(
            children: [
              Stack(children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Hero(
                      tag: '${profileUser.photoURL}',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profileUser.photoURL),
                        radius: 50,
                      ),
                    ),
                  ),
                ),
                (currentUser.uid==userId)?Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent, // button color
                        elevation: 0.0,
                        child: InkWell(
                          splashColor: Colors.blueGrey, // inkwell color
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.edit,
                                size: 25,
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUsername(userName:profileUser.userName,fn:updateUserName)));
                          },
                        ),
                      ),
                    )):Container(),
              ]),
              SizedBox(height: 25),
              Center(
                  child: Text(
                    profileUser.userName,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
              )),
              SizedBox(height: 10),
              Center(
                child: Text(profileUser.displayName,
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black45,
                      fontSize: 15,
                      letterSpacing: 1,
                    )),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(profileUser.email,
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black45,
                      fontSize: 15,
                      letterSpacing: 1,
                    )),
              ),
              SizedBox(height: 35),
              Divider(),
              SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text((currentUser.uid==userId)?"Your Rooms":"Mutual Rooms",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.blueAccent,
                      ))),
              SizedBox(height: 15),
              Container( 
                padding: EdgeInsets.all(0),
                child: (currentUser.uid==userId)?BinDatabase().showRoomsInProfile(currentUser.uid):BinDatabase().showCommonRoomsInProfile(currentUser.uid,userId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
