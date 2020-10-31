import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/pages/home/binCard.dart';
import 'package:doubtbin/pages/profile/editUsename.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //  this is temporary list (for demonstration)
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
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar("Profile"),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen]
              )
          ),
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
                                color: Colors.blue,
                                size: 25,
                              )),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditUsername()
                            ));
                          },
                        ),
                      ),
                    )),
              ]),
              SizedBox(height: 7),
              Center(
                  child: Text(
                user.userName,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              )),
              SizedBox(height: 10),
              Center(
                  child: Text(user.displayName,
                      style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.black45,
                        fontSize: 30,
                        letterSpacing: 1,
                      ))),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(_user(),
                      style: TextStyle(
                        fontSize: 20,
                      ))),
              Column(
//            scrollDirection: Axis.vertical,
                children: bins
                    .map((bin) => BinCard.profile(
                          bin: bin,
                          pad: 0,
                          elevation: 1,
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
