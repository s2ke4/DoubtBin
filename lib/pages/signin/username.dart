import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Username"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                hintText: "enter username....",
                hintStyle: TextStyle(color: Colors.black54)),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xff007EF4),
              const Color(0xFF2A75BC),
            ])),
            child: Text("Enter"),
          )
        ]),
      ),
    );
  }
}
