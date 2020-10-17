import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/post.dart';


class BinDatabase{

  final String roomCode;
  final String user;
  BinDatabase({this.roomCode,  this.user});

  final CollectionReference binCollection = FirebaseFirestore.instance.collection('bins');

  Future createRoom(String roomCode, String displayName, String description) async{

    return await binCollection.doc(roomCode).set({

        "roomCode": roomCode,
        "displayName": displayName,
        "description": description,
      });
  }

  Future addmembers(String uid) async{

    return await binCollection.doc(roomCode).collection('members').doc(uid).set({
      "uid": uid,
    });
  }

  List<Post> _brewListFromSnapshot(QuerySnapshot snapshot) {
    print("kamal hai bhaishabh 2");
    return snapshot.docs.map((doc){
      return Post(
        postID: doc.data()['postID'],
        postHeading: doc.data()['postHeading'],
        postBody: doc.data()['postBody'],
        author: doc.data()['author'],
        isResolved: doc.data()['isResolved'],
        numberOfAttachment: doc.data()['numberOfAttachment'],
        numberOfComments: doc.data()['numberOfComments'],
        numberOfLikes: doc.data()['numberOfLikes'],
        numberOfDislikes: doc.data()['numberOfDislikes'],
      );
    }).toList();
  }

  Stream<List<Post>> get posts {
    return binCollection.doc(roomCode).collection('posts').snapshots().map(_brewListFromSnapshot);
  }

  Future addPost(
    String postID,
    String postHeading,
    String postBody,
    String author,
    bool isResolved,
    int numberOfAttachment,
    int numberOfComments,
    int numberOfLikes,
    int numberOfDislikes,) async{

    posts;

    print("kamal hai bhaishabh  1");

      return await binCollection.doc(roomCode).collection('posts').doc(postID).set({
        "postID": postID,
        "postHeading" : postHeading,
        "postBody" : postBody,
        "author" : author,
        "isResolved" : isResolved,
        "numberOfAttachment" : numberOfAttachment,
        "numberOfComments" : numberOfComments,
        "numberOfLikes" : numberOfLikes,
        "numberOfDislikes" :numberOfDislikes ,
      });

  } 

}