import 'package:doubtbin/pages/aboutus/aboutus.dart';
import 'package:doubtbin/pages/home/burgermenu/userinfo.dart';
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen]
                )
              ),
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(10,15,0,15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DoubtBin',
                      style: TextStyle(
                        fontFamily: 'AppBarFont',
                        fontSize: 25,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                   // Divider(),
                    UserInfo(),
                  ],
                ),
                // decoration: BoxDecoration(
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black,
                //       blurRadius: .7,
                //     )
                //   ],
                //   color: Colors.white, //the box in which user info is stored
                // ),
              ),
            ),
            Container(
               padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
               color: Colors.grey[200],
               child: Align(
                 alignment: Alignment.topLeft,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 2),
                   child: (
                       Text(
                         'Your rooms',
                         style: TextStyle(
                           fontSize: 15,
                           color: Colors.grey[600],
                           fontWeight: FontWeight.w800,
                         ),
                       )
              ),
                 ),
               ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[200], Colors.white],

                  )
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                              //print("Card Clicked");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoomDashboard(
                                            roomCode: "123456789", //this we will fetch from firebase on linking backend
                                            firstTime:
                                                false, //true only when the user creates or joins the room and then visits it for first time
                                          )));
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>PostPage())),
                            },
                          ))
                      .toList(),
                ),
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
