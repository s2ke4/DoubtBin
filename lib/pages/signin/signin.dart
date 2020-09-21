import 'package:doubtbin/pages/signin/signinbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doubtbin/shared/loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool loading = false;
  void toggleLoading(){
    setState(()=>loading=true);
  }

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7sc6Oej7nW5qlM9upQlryA-QVL89yaZQA5Q&usqp=CAU'),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 80,0, 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Welcome to  ',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'DoubtBin',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: .6,
                child: Text(
                  ' Understand Better ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50,0, 50),
                child: SvgPicture.asset(
                  'assets/log1.svg',
                  width: 180,
                  height: 220,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0,0, 10),
                child: Opacity(
                  opacity: .6,
                  child: Text(
                    'Connect with Google',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            SignButton(toggleLoading:toggleLoading),
          ],
        ),
      )
    );
  }
}