import 'package:flutter/material.dart';
import 'burgermenu/burgermenu.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[900]),
        title: Text(
          "DoubtBin",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: BurgerMenu(),
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
      ),

    );
  }
}