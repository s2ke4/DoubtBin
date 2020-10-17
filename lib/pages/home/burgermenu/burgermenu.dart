import 'package:doubtbin/pages/aboutus/aboutus.dart';
import 'package:doubtbin/pages/home/burgermenu/userinfo.dart';
import 'package:doubtbin/pages/signin/username.dart';
import 'package:doubtbin/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';

class BurgerMenu extends StatefulWidget {
  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  final AuthServices _auth = AuthServices();
  List<Bin> bins = [
    Bin(
      owner: 'Ashish Phophalia & Novarun Deb',
      binName: 'CS201/CS261',
    ),
    Bin(
      owner: 'Naveen Kumar',
      binName: 'CS203/CS263',
    ),
    Bin(
      owner: 'Bhupendra Kumar',
      binName: 'MA201',
    ),
    Bin(
      owner: 'Kamal Kishor Jha',
      binName: 'EC201/EC261',
    ),
    Bin(
      owner: 'Dhirendra Kumar Sinha',
      binName: 'EE160',
    ),
    Bin(
      owner: 'Amandeep Singh',
      binName: 'HS201',
    ),
    Bin(
      owner: 'Vikas Kumar',
      binName: 'SC201',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              //height: 250,
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(15,20,0,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DoubtBin',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    UserInfo(),
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: .7,
                    )
                  ],
                  color: Colors.white, //the box in which user info is stored
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                children: bins
                    .map((bin) => ListTile(
                          title: Text(
                            bin.binName,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            print("Card Clicked");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoomDashboard(
                                          roomCode: "123456789", //this we will fetch from firebase on linking backend
                                          firstTime:
                                              false, //true only when the user creates or joins the room and then visits it for first time
                                          bin: bin,
                                        )));
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>PostPage())),
                          },
                        ))
                    .toList(),
              ),
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
