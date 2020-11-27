import 'package:doubtbin/pages/rooms/detailedPost/deletePopUp.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {

  String code,uid;
  ExitButton({this.code,this.uid});

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
              onPressed: ()async{
                await deletePopUp(roomCode:code,isDeletePost: false,userId:uid).deletePost(context,"Are You Sure You Want to Exit From this Room","Exit");
              },
            );
  }
}