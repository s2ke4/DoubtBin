import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/pages/home/binCard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';


class Profile extends StatefulWidget {

//  this is temporary list (for demonstration)
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Bin> bins = [
    Bin(
        owner: 'Ashish Phophalia & Novarun Deb',
        binName: 'CS201/CS261',
        color: 'Colors.red[200]'),
    Bin(
        owner: 'Naveen Kumar',
        binName: 'CS203/CS263',
        color: 'Colors.red[200]'),

    Bin(owner: 'Bhupendra Kumar', binName: 'MA201', color: 'Colors.red[200]'),
    Bin(
        owner: 'Kamal Kishor Jha',
        binName: 'EC201/EC261',
        color: 'Colors.red[200]'),
    Bin(
        owner: 'Dhirendra Kumar Sinha',
        binName: 'EE160',
        color: 'Colors.red[200]'),
    Bin(owner: 'Amandeep Singh', binName: 'HS201', color: 'Colors.red[200]'),
    Bin(owner: 'Vikas Kumar', binName: 'SC201', color: 'Colors.red[200]'),
  ];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    String _user(){
      String tittle = user.email == user.email ? "Your Rooms ": "Mutual Rooms";
      return tittle;
    }

    return Scaffold(
      appBar: appBar("Profile"),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Hero(
                tag: '$user.photoURL',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL),
                  radius: 50,
                ),
              ),
            ),
          ),

          SizedBox(height: 7),
          Center(child: Text('Lone.Star', style: TextStyle(fontSize: 17, letterSpacing: 2, ),)),
          SizedBox(height: 10),
          Center(child: Text(user.displayName, style: TextStyle(fontSize: 30, letterSpacing: 1,))),
          SizedBox(height: 20),


          Text(_user() , style: TextStyle(fontSize: 20, )),

          Column(
//            scrollDirection: Axis.vertical,
            children: bins.map((bin) => BinCard(bin: bin)).toList(),
          )
        ],
      ),
    );
  }
}