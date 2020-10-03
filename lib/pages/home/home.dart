import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'burgermenu/burgermenu.dart';
import 'floatingactionbutton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: appBar(),
      drawer: BurgerMenu(),
      body: Column(
        children:<Widget>[
          Center(
            child:Text("Dashboard")
          )
        ]
      ),
      floatingActionButton: FloatButton(),
    );
  }
}