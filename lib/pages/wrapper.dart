import 'package:flutter/material.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/signin/signin.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if(user==null){
      return SignInPage();
    }else{
      return Home();
    }
  }
}