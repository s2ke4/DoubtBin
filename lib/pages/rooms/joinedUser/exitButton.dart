import 'package:doubtbin/services/room.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {

  String code,uid;
  ExitButton({this.code,this.uid});

  ExitUser(BuildContext context){
    BinDatabase().exitFromBin(code,uid);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              textColor: Colors.red,
              child:Row(
                children:[
                  Icon(Icons.exit_to_app,size: 27,),
                  SizedBox(width:10),
                  Text("Exit From Room",style: TextStyle(color:Colors.red,fontSize: 16),),
                ]
              ),
              onPressed: (){ExitUser(context);},
            );
  }
}