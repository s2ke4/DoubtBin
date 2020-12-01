import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/rooms/detailedPost/detailedPost.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/pages/home/home.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String roomCode;
  PostCard({this.post,this.roomCode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPost(post:post,roomCode:roomCode)));
      },
      child: Container(
         padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Card(
              elevation: 2.0,
              shadowColor: Colors.grey[400],
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            post.postHeading.length > 28? 
                              (post.postHeading.substring(0,25) + "...")
                              :post.postHeading,
                            style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                        ]),
                        post.isResolved == true
                            ? (Icon(
                                Icons.check,
                                color: Colors.green[900],
                                size: 30,
                              ))
                            : (Icon(
                                Icons.access_time,
                                color: Colors.red,
                                size: 30,
                              )),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      post.postBody.length > 200
                          ? (post.postBody.substring(0, 196) + '....')
                          : post.postBody,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          post.liked == null || post.liked.contains(currentUser.uid) == false ? Icon(Icons.thumb_up, size:27) : Icon(Icons.thumb_up,color: Colors.blue[500], size:27),
                          SizedBox(width: 10),
                          Text(post.numberOfLikes.toString()),
                          SizedBox(width: 15),
                          post.disliked == null || post.disliked.contains(currentUser.uid) == false ? Icon(Icons.thumb_down, size:27) : Icon(Icons.thumb_down,color: Colors.red[500], size:27),
                          SizedBox(width: 10),
                          Text(post.numberOfDislikes.toString()),
                          SizedBox(width: 15),
                          Icon(Icons.image, size: 27),
                          SizedBox(width: 10),
                          Text(post.numberOfAttachment.toString()),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(children: [
                            Icon(Icons.comment, size: 27),
                            SizedBox(width: 10),
                            Text(post.numberOfComments.toString()),
                          ]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

    );

  }
}
