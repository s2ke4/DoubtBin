import 'package:doubtbin/pages/aboutus/aboutus.dart';
import 'package:doubtbin/pages/home/burgermenu/userinfo.dart';
import 'package:doubtbin/services/auth.dart';
import 'package:doubtbin/services/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class BurgerMenu extends StatefulWidget {
  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              //height: 250,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color(0xff007EF4),
                const Color(0xFF2A75BC),
              ])),
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DoubtBin',
                      style: TextStyle(
                        fontFamily: 'AppBarFont',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Divider(),
                    UserInfo(),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: (Text(
                    'Your Rooms',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w800,
                    ),
                  )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(0),
                child: BinDatabase().showRoomsInBurger(currentUser.uid),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ListTile(
                title: Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs())),
              ),
              alignment: Alignment.bottomLeft,
            ),
            FlatButton(
              onPressed: () {
                _auth.signOutGoogle();
              },
              child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 9),
                      Text(
                        'Log Out',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
