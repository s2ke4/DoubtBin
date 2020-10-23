import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/home/binCard.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/postCard.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/cupertino.dart';

 final CollectionReference binCollection = FirebaseFirestore.instance.collection('bins');

class BinDatabase{

  final String roomCode;
  final String user;
  BinDatabase({this.roomCode,  this.user});

 
 Future createRoom(String roomCode, String displayName, String description) async{

    await binCollection.doc(roomCode).set({
        "roomCode": roomCode,
        "displayName": displayName,
        "description": description,
        "ownerName":currentUser.userName,
        "ownerId":currentUser.uid
      });
  }

 Future addmembers(String uid) async{
   await binCollection.doc(roomCode).collection('members').doc(uid).set({
      "member":true,
    });
  }

  Future joinRoom(String uid) async{
    await userRef.doc(uid).collection("joinedRoom").doc(roomCode).set({
      "joined":true
    });
  }

  showRoom(String userId){
    return StreamBuilder(
      stream:userRef.doc(userId).collection("joinedRoom").snapshots(),
      builder:(context,snapshot){
        if(!snapshot.hasData){
          return Loading();
        }
        List<BinCard> allCard = [];
        snapshot.data.docs.map((doc)async{
          final coll = await binCollection.doc(doc.id).get();
          String binName= coll.data()['displayName'];
          String ownerId=coll.data()['ownerId'];
          String ownerName = coll.data()['ownerName'];
          String roomId = doc.id;
          print(binName);
          allCard.add(BinCard(
            bin:Bin( binName: binName,owner: ownerName,roomId: roomId)
          ));
        }).toList();

        return ListView(
          children:allCard
        );
      }
    );
  }

  //when a person joined a room then
  //we will include that person in the member collection of that room
  //we will include that room in the joined room collection of that person

  //check room code to join room
  checkingCode(String userId)async{
    bool found = false;
    String name;
    await binCollection.get().then((documents){
      if(documents!=null){
        for(var doc in documents.docs) {
          if(doc.id==roomCode){
            found = true;
            name = doc.data()['displayName'];
            break;
          }
        };
      }
    });
    if(found)
    {
      await userRef.doc(userId).collection("joinedRoom").doc(roomCode).set({
        "joined":true
      });
      await binCollection.doc(roomCode).collection("members").doc(userId).set({
        "member":true
      });
      return name;
    }
    return null;
  }

  showAllPost(){
    return StreamBuilder(
      stream:binCollection.doc(roomCode).collection("posts").snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Loading();
        }
        if(snapshot.data.docs.isEmpty){
          return Center(child:Text("No Post Yet",style: TextStyle(fontSize: 18)));
        }
        List<PostCard> allposts = [];
        snapshot.data.docs.map((doc){
          allposts.add(
            PostCard(
              post:Post(
                    postID: doc.data()['postID'],
                    postHeading: doc.data()['postHeading'],
                    postBody: doc.data()['postBody'],
                    author: doc.data()['author'],
                    isResolved: doc.data()['isResolved'],
                    numberOfAttachment: doc.data()['numberOfAttachment'],
                    numberOfComments: doc.data()['numberOfComments'],
                    numberOfLikes: doc.data()['numberOfLikes'],
                    numberOfDislikes: doc.data()['numberOfDislikes'],
                  ),
              roomCode:roomCode
            )
          );
        }).toList();
        return ListView(
          children: allposts,
        );
      },
    );
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

      await binCollection.doc(roomCode).collection('posts').doc(postID).set({
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