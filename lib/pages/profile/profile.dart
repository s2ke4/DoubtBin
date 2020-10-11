import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';


class Profile extends StatelessWidget {

//  this is temporary list (for demonstration)
  List <String> bins = ["Bin 1", "Bin 2", "Bin 3", "Bin 4","Bin 5", "Bin 6","Bin 7", "Bin 8","Bin 9", "Bin 10" ];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    String _user(){
      String tittle = user.email == user.email ? "Your Rooms ": "Mutual Rooms";
      return tittle;
    }

    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Hero(
                tag: '$user.photoURL',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL),
                  radius: 50,
                ),
              ),
            ),
            SizedBox(height: 7),
            Text('Lone.Star', style: TextStyle(fontSize: 17, letterSpacing: 2, ),),
            SizedBox(height: 10),
            Text(user.displayName, style: TextStyle(fontSize: 30, letterSpacing: 1,)),
            SizedBox(height: 20),
            Text(_user(), style: TextStyle(fontSize: 20,)),
            Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: bins.map((bin) => BinList(bin: bin)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BinList extends StatelessWidget {

  final  bin;
  BinList({this.bin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              bin,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
