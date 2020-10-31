import 'package:doubtbin/services/room.dart';
import 'package:flutter/material.dart';

class deletePopUp{
  Future<void> deletePost(parentContext,String roomCode,String postID,List<dynamic> images){
    return showDialog(
        context: parentContext,
        builder: (context){
          return SimpleDialog(
            title: Text("Delete this Doubt?"),
            children: [
              Padding(
                padding: const EdgeInsets.only(left:25.0,right:25,top:20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    GestureDetector(
                      child:Text("Delete",style:TextStyle(color: Colors.red,fontSize:18)),
                      onTap:()async{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        await BinDatabase(roomCode:roomCode).deletePost(postID,images);
                      }
                    ),
                    GestureDetector(
                      child:Text("Cancel",style:TextStyle(fontSize:18)),
                      onTap:(){Navigator.pop(context);}
                    )
                  ]
                ),
              )
            ],
          );
        }
    );
  }
}