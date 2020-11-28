import 'package:doubtbin/pages/profile/editUsename.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:doubtbin/pages/home/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    String _user() {
      String tittle = user.email == user.email ? "Your Rooms " : "Mutual Rooms";
      return tittle;
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.grey[400], Colors.white],
        //transform: GradientRotation(pi/4),
      )),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: appBar("Profile"),
        body: Container(
          child: ListView(
            children: [
              Stack(children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Hero(
                      tag: '$user.photoURL',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL),
                        radius: 50,
                      ),
                    ),
                  ),
                ),
                Container(
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
                                    builder: (context) => EditUsername()));
                          },
                        ),
                      ),
                    )),
              ]),
              SizedBox(height: 25),
              Center(
                  child: Text(
                currentUser.userName,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              )),
              SizedBox(height: 10),
              Center(
                child: Text(currentUser.displayName,
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black45,
                      fontSize: 15,
                      letterSpacing: 1,
                    )),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(currentUser.email,
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
                  child: Text(_user(),
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.blueAccent,
                      ))),
              SizedBox(height: 15),
              Container(
                child: BinDatabase().showRoomsInBurger(currentUser.uid),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
