import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/comment.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/detailedPost/deletePopUp.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

enum commentEnum{delete}

class Comment extends StatefulWidget {

  final commentModel comment;
  String postId,commentId,roomId;
  Function removeNumberOfComment;
  Comment({this.comment,this.postId,this.commentId,this.roomId,this.removeNumberOfComment});
  
  @override
  _CommentState createState() => _CommentState();

}

class _CommentState extends State<Comment> {
  bool isLoading = true;
  String circleAvatar,userName;

  @override
  void initState(){
    super.initState();
    print("hello");
  }
  Future<void> getInfo()async{
     DocumentSnapshot doc = await userRef.doc(widget.comment.commentAuthor).get();
     circleAvatar = doc.data()["circleAvatar"];
     userName = doc.data()["userName"];
     if(this.mounted){setState(()=>isLoading= false);}
  }

  void performOperation(result){
     switch(result){
      case commentEnum.delete:
        deletePopUp(roomCode: widget.roomId,postId: widget.postId,isDeletePost: false,commentId:widget.commentId,removeNumberOfComment:widget.removeNumberOfComment).deletePost(context, "Are You Sure You Want to Delete This Comment", "Delete");
        break;
     }
  }
 
  @override
  Widget build(BuildContext context) {
    getInfo();
    return Container(
      margin: EdgeInsets.only(left:10,top: 15,right: 5),
      child: Bubble(
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(240, 240, 240, 1.0),
              child:Padding(
                padding: const EdgeInsets.fromLTRB(5,5,0,5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children:[
                            isLoading?Loading():CircleAvatar(backgroundImage: NetworkImage(circleAvatar),radius: 16,),
                            SizedBox(width: 10,),
                            isLoading?Loading():Text(userName,style: TextStyle(fontSize: 16),)
                          ],
                        ),
                        (currentUser.uid==widget.comment.commentAuthor)?PopupMenuButton<commentEnum>(
                                onSelected: (commentEnum result) { performOperation(result); },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<commentEnum>>[
                                  PopupMenuItem<commentEnum>(
                                    value: commentEnum.delete,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delete this comment'),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  ),
                                ]
                        ):Container()
                      ],
                    ),
                    SizedBox(height:10),
                    Text(widget.comment.comment,style:TextStyle(fontSize: 16)),
                    SizedBox(height: 13,),
                    Row(
                      children: [
                        Icon(Icons.thumb_up,size:20 ),
                        SizedBox(width: 5),
                        Text(widget.comment.numberOfLikes.toString(),style: TextStyle(fontSize: 12),),
                        SizedBox(width: 18),
                        Icon(Icons.thumb_down,size: 20,),
                        SizedBox(width: 5),
                        Text(widget.comment.numberOfDislikes.toString(),style: TextStyle(fontSize: 12),)
                      ],
                    )
                  ],
                ),
              )
            ),
    );
      }
}
