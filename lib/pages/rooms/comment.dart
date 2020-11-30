import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/comment.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {

  final commentModel comment;

  Comment({this.comment});
  
  @override
  _CommentState createState() => _CommentState();

}

class _CommentState extends State<Comment> {
  bool isLoading = true;
  String circleAvatar,userName;

  // @override
  // void initState(){
  //   super.initState();
  //   getInfo();
  // }
  Future<void> getInfo()async{
     DocumentSnapshot doc = await userRef.doc(widget.comment.commentAuthor).get();
     circleAvatar = doc.data()["circleAvatar"];
     userName = doc.data()["userName"];
     if(this.mounted){setState(()=>isLoading= false);}
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
                      children:[
                        isLoading?Loading():CircleAvatar(backgroundImage: NetworkImage(circleAvatar),radius: 16,),
                        SizedBox(width: 10,),
                        isLoading?Loading():Text(userName,style: TextStyle(fontSize: 16),)
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
