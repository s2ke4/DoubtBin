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
            onPressed:() async {await _auth.signOutGoogle();print("from home.dart");print(user);},
             icon: Icon(Icons.person),
            label: Text("Log Out"))
        ],
      ),
    );
  }
}