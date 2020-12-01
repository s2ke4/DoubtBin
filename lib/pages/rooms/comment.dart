import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/comment.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/profile/profile.dart';
import 'package:doubtbin/pages/rooms/detailedPost/deletePopUp.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

enum commentEnum { delete }

class Comment extends StatefulWidget {
  final commentModel comment;
  String postId, commentId, roomId;
  Function removeNumberOfComment;
  Comment(
      {this.comment,
      this.postId,
      this.commentId,
      this.roomId,
      this.removeNumberOfComment});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isLoading = true, isLiked, isDisLiked = false;
  String circleAvatar, userName;

  Future<void> getInfo() async {
    setState(() {
      isLiked =
          (widget.comment.likedUser[currentUser.uid] == true) ? true : false;
      isDisLiked =
          (widget.comment.disLikedUser[currentUser.uid] == true) ? true : false;
    });
    DocumentSnapshot doc =
        await userRef.doc(widget.comment.commentAuthor).get();
    circleAvatar = doc.data()["circleAvatar"];
    userName = doc.data()["userName"];
    if (this.mounted) {
      setState(() => isLoading = false);
    }
  }

  void performOperation(result) {
    switch (result) {
      case commentEnum.delete:
        deletePopUp(
                roomCode: widget.roomId,
                postId: widget.postId,
                isDeletePost: false,
                commentId: widget.commentId,
                removeNumberOfComment: widget.removeNumberOfComment)
            .deletePost(context, "Are You Sure You Want to Delete This Comment",
                "Delete");
        break;
    }
  }

  void handleLike() {
    setState(() {
      widget.comment.numberOfDislikes = isDisLiked
          ? widget.comment.numberOfDislikes - 1
          : widget.comment.numberOfDislikes;
      widget.comment.disLikedUser[currentUser.uid] = false;
      widget.comment.likedUser[currentUser.uid] = !isLiked;
      widget.comment.numberOfLikes = widget.comment.likedUser[currentUser.uid]
          ? widget.comment.numberOfLikes + 1
          : widget.comment.numberOfLikes - 1;
    });
    BinDatabase().likeComment(
        widget.roomId,
        widget.postId,
        widget.commentId,
        widget.comment.likedUser[currentUser.uid],
        widget.comment.numberOfLikes,
        widget.comment.disLikedUser[currentUser.uid],
        widget.comment.numberOfDislikes);
  }

  void handleDislike() {
    setState(() {
      widget.comment.numberOfLikes = isLiked
          ? widget.comment.numberOfLikes - 1
          : widget.comment.numberOfLikes;
      widget.comment.likedUser[currentUser.uid] = false;
      widget.comment.disLikedUser[currentUser.uid] = !isDisLiked;
      widget.comment.numberOfDislikes =
          widget.comment.disLikedUser[currentUser.uid]
              ? widget.comment.numberOfDislikes + 1
              : widget.comment.numberOfDislikes - 1;
    });
    BinDatabase().disLikeComment(
        widget.roomId,
        widget.postId,
        widget.commentId,
        widget.comment.disLikedUser[currentUser.uid],
        widget.comment.numberOfDislikes,
        widget.comment.likedUser[currentUser.uid],
        widget.comment.numberOfLikes);
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 5),
      child: Bubble(
          nip: BubbleNip.leftTop,
          color: Color.fromRGBO(240, 240, 240, 1.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    userId: widget.comment.commentAuthor)));
                      },
                      child: Row(
                        children: [
                          isLoading
                              ? Loading()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(circleAvatar),
                                  radius: 16,
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          isLoading
                              ? Loading()
                              : Text(
                                  userName,
                                  style: TextStyle(fontSize: 16),
                                )
                        ],
                      ),
                    ),
                    (currentUser.uid == widget.comment.commentAuthor)
                        ? PopupMenuButton<commentEnum>(
                            onSelected: (commentEnum result) {
                              performOperation(result);
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<commentEnum>>[
                                  PopupMenuItem<commentEnum>(
                                    value: commentEnum.delete,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delete this comment'),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  ),
                                ])
                        : Container()
                  ],
                ),
                SizedBox(height: 10),
                Text(widget.comment.comment, style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: isLiked
                          ? Icon(Icons.thumb_up,
                              color: Colors.blue[500], size: 20)
                          : Icon(Icons.thumb_up, size: 20),
                      onPressed: handleLike,
                    ),
                    Text(
                      widget.comment.numberOfLikes.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 18),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: isDisLiked
                          ? Icon(Icons.thumb_down,
                              color: Colors.red[500], size: 20)
                          : Icon(Icons.thumb_down, size: 20),
                      onPressed: handleDislike,
                    ),
                    Text(
                      widget.comment.numberOfDislikes.toString(),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
