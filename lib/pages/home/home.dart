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
import '../../model/bin.dart';
import 'binCard.dart';

final CollectionReference userRef = FirebaseFirestore.instance.collection("Users");
MyUser currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCheck = false;
  bool firstTime=true;

  List<Bin> bins = [
    Bin(
      owner: 'Ashish Phophalia & Novarun Deb',
      binName: 'CS201/CS261',
    ),
    Bin(
      owner: 'Naveen Kumar',
      binName: 'CS203/CS263',
    ),
    Bin(
      owner: 'Bhupendra Kumar',
      binName: 'MA201',
    ),
    Bin(
      owner: 'Kamal Kishor Jha',
      binName: 'EC201/EC261',
    ),
    Bin(
      owner: 'Dhirendra Kumar Sinha',
      binName: 'EE160',
    ),
    Bin(
      owner: 'Amandeep Singh',
      binName: 'HS201',
    ),
    Bin(
      owner: 'Vikas Kumar',
      binName: 'SC201',
    ),
  ];

  switchHomeAndUserName(MyUser us){
    currentUser = us;
    setState(()=>firstTime=false);
  }

  checkingForUserName()async{
    MyUser _user = Provider.of<MyUser>(context);
    DocumentSnapshot userData  = await userRef.doc(_user.uid).get();
    if(userData.exists){
      setState((){
        isCheck = true;
        firstTime = false;
      });
      currentUser = MyUser.creatingUser(userData);
    }else{
      setState(()=>isCheck = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkingForUserName();
    return !isCheck?Loading():(firstTime)?new Username(switchHomeAndUserName):Scaffold(
      appBar: appBar("DoubtBin"),
      drawer: BurgerMenu(),
      body: BinDatabase().showRoom(currentUser.uid),
      floatingActionButton: FloatButton(),
    );
  }
}