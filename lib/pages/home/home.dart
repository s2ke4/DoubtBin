import 'package:flutter/material.dart';
import 'package:doubtbin/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("DoubtBin"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed:() async {await _auth.signOutGoogle();},
             icon: Icon(Icons.person),
            label: Text("Log Out"))
        ],
      ),
      body: Column(
        children:<Widget>[
          Center(
            child:Padding(
              padding: EdgeInsets.fromLTRB(100, 50, 10, 10),
              child:Text(
              "You Are logged in as ${user.email}",
              style: TextStyle(fontSize: 20),
              )
              )
          )
        ]
      )
    );
  }
}