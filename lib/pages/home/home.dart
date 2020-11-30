import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/signin/username.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'burgermenu/burgermenu.dart';
import 'floatingbutton/floatingactionbutton.dart';

final CollectionReference userRef = FirebaseFirestore.instance.collection("Users");
MyUser currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCheck = false;
  bool firstTime=true;

  switchHomeAndUserName(MyUser us){
    currentUser = us;
    if(this.mounted){setState(()=>firstTime=false);}
  }

  checkingForUserName()async{
    MyUser _user = Provider.of<MyUser>(context);
    DocumentSnapshot userData  = await userRef.doc(_user.uid).get();
    if(userData.exists && this.mounted){
      setState((){
        isCheck = true;
        firstTime = false;
      });
      currentUser = MyUser.creatingUser(userData);
    }else if(this.mounted){
      setState(()=>isCheck = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkingForUserName();
    return !isCheck?Loading():(firstTime)?new Username(switchHomeAndUserName):Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[400], Colors.white],
          //transform: GradientRotation(pi/4),
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: appBar("DoubtBin"),
        drawer: BurgerMenu(),
        body: BinDatabase().showRoom(currentUser.uid),
        floatingActionButton: FloatButton(),
      ),
    );
  }
}