import 'package:doubtbin/pages/rooms/detailedPost/detailedPost.dart';
import 'package:doubtbin/services/room.dart';
import 'package:flutter/material.dart';

class deletePopUp{

  String roomCode,postId,userId,commentId;
  Function removeNumberOfComment;
  List<dynamic> images;
  bool isDeletePost;
  deletePopUp({this.roomCode,this.postId,this.userId,this.images,this.isDeletePost,this.commentId,this.removeNumberOfComment});

  Future<void> deletePost(parentContext,String alertmsg,String btnmsg){
    return showDialog(
        context: parentContext,
        builder: (context){
          return SimpleDialog(
            title: Text(alertmsg),
            children: [
              Padding(
                padding: const EdgeInsets.only(left:25.0,right:25,top:20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    GestureDetector(
                      child:Text(btnmsg,style:TextStyle(color: Colors.red,fontSize:18)),
                      onTap:()async{
                        if(isDeletePost){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          await BinDatabase(roomCode:roomCode).deletePost(postId,images);
                        }else if(btnmsg=="Delete"){
                          Navigator.pop(context);
                          removeNumberOfComment();
                          await BinDatabase(roomCode:roomCode).deleteComment(postId,commentId);
                        }else{
                          if(btnmsg=="Exit"){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                          Navigator.pop(context);
                          await BinDatabase().exitFromBin(roomCode,userId);
                        }
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