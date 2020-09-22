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
    setState(()=>loading = !loading);
  }

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*.52,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(40),
                        bottomRight: const Radius.circular(40),
                      )
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 120,0, 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'DoubtBin',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15,0, 0),
                          child: Center(
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
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 280,0, 50),
                    child: SvgPicture.asset(
                      'assets/log1.svg',
                      width: 180,
                      height: 220,
                    ),
                  ),
                ),
              ],
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