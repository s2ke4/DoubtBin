import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/binCard.dart';
import 'package:doubtbin/pages/home/burgermenu/burgerRoomTile.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/postCard.dart';
import 'package:doubtbin/pages/rooms/joinedUser/userTile.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

final CollectionReference binCollection =  FirebaseFirestore.instance.collection('bins');
final StorageReference storageRef = FirebaseStorage.instance.ref();
final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');


class BinDatabase {
  final String roomCode;
  final String user;
  final String uid;
  BinDatabase({this.roomCode, this.user, this.uid});

  Future updateUserData(String displayName, String userName, String uid,
      String email, String photoURL) async {
    return await userCollection.doc(uid).set({
      "uid": uid,
      "displayName": displayName,
      "userName": userName,
      "email": email,
      "photoURL": photoURL,
    });
  }

  Future createRoom(String roomCode, String displayName, String description) async {
    await binCollection.doc(roomCode).set({
      "roomCode": roomCode,
      "displayName": displayName,
      "description": description,
      "ownerName": currentUser.userName,
      "ownerId": currentUser.uid
    });
  }

  Future addmembers(String uid) async {
    await binCollection.doc(roomCode).collection('members').doc(uid).set({
      "member": true,
    });
  }

  Future joinRoom(String uid) async {
    await userRef
        .doc(uid)
        .collection("joinedRoom")
        .doc(roomCode)
        .set({"joined": true});
  }

  showRoom(String userId) {
    return StreamBuilder(
      stream: userRef.doc(userId).collection("joinedRoom").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Future<DocumentSnapshot>> collFuture = List();
        snapshot.data.docs.forEach((doc) {
          collFuture.add(binCollection.doc(doc.id).get());
        });

        return snapshot.hasData ? FutureBuilder<List<DocumentSnapshot>>(
          future: Future.wait<DocumentSnapshot>(collFuture),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BinCard> allCard = [];
              snapshot.data.forEach((docSnap) {
                allCard.add(
                  BinCard(
                    bin: Bin(
                      description: docSnap.data()['description'],
                      binName: docSnap.data()['displayName'],
                      owner: docSnap.data()['ownerName'],
                      roomId: docSnap.id,
                    ),
                  ),
                );
              });
              if (allCard.length == 0) {
                return Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Center(
                          child: Text(
                        "You are not a member of any room.",
                        style: TextStyle(fontSize: 16),
                      )),
                      Center(
                          child: Text(
                              "Room you will create or join will appear here.",
                              style: TextStyle(fontSize: 16)))
                    ]));
              }
              return ListView(children: allCard);
            } else {
              return Container(
                child: Loading(),
              );
            }
          },
        ): Container();
      },
    );
  }

  //this is used to display the list of rooms in the burgermenu.
  showRoomsInBurger(String userId) {
    return StreamBuilder(
      stream: userRef.doc(userId).collection("joinedRoom").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Future<DocumentSnapshot>> collFuture = List();
        snapshot.data.docs.forEach((doc) {
          collFuture.add(binCollection.doc(doc.id).get());
        });

        return FutureBuilder<List<DocumentSnapshot>>(
          future: Future.wait<DocumentSnapshot>(collFuture),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BurgerRoomTile> allCard = [];
              snapshot.data.forEach((docSnap) {
                allCard.add(
                  BurgerRoomTile(
                    bin: Bin(
                      description: docSnap.data()['description'],
                      binName: docSnap.data()['displayName'],
                      owner: docSnap.data()['ownerName'],
                      roomId: docSnap.id,
                    ),
                  ),
                );
              });
              if (allCard.length == 0) {
                return Container(
                    child: Center(
                        child: Text("No Room to Show",
                            style: TextStyle(fontSize: 16))));
              }
              return ListView(children: allCard);
            } else {
              return Container(
                child: Loading(),
              );
            }
          },
        );
      },
    );
  }

  showRoomsInProfile(String userId) {
    return StreamBuilder(
      stream: userRef.doc(userId).collection("joinedRoom").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Future<DocumentSnapshot>> collFuture = List();
        snapshot.data.docs.forEach((doc) {
          collFuture.add(binCollection.doc(doc.id).get());
        });

        return FutureBuilder<List<DocumentSnapshot>>(
          future: Future.wait<DocumentSnapshot>(collFuture),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BurgerRoomTile> allCard = [];
              snapshot.data.forEach((docSnap) {
                allCard.add(
                  BurgerRoomTile(
                    bin: Bin(
                      description: docSnap.data()['description'],
                      binName: docSnap.data()['displayName'],
                      owner: docSnap.data()['ownerName'],
                      roomId: docSnap.id,
                    ),
                  ),
                );
              });
              if (allCard.length == 0) {
                return Container(
                    child: Center(
                        child: Text("No Room to Show",
                            style: TextStyle(fontSize: 16))));
              }
              return Column(children: allCard);
            } else {
              return Container(
                child: Loading(),
              );
            }
          },
        );
      },
    );
  }

  //when a person joined a room then
  //we will include that person in the member collection of that room
  //we will include that room in the joined room collection of that person

  //check room code to join room
  Future<bool> checkingCode(String userId) async {
    DocumentSnapshot doc = await binCollection.doc(roomCode).get();
    bool found = doc.exists;
    if (found) {
      userRef
          .doc(userId)
          .collection("joinedRoom")
          .doc(roomCode)
          .set({"joined": true});
      binCollection
          .doc(roomCode)
          .collection("members")
          .doc(userId)
          .set({"member": true});
      return true;
    }
    return false;
  }

  showAllPost() {
    return StreamBuilder(
      stream: binCollection.doc(roomCode).collection("posts").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        if (snapshot.data.docs.isEmpty) {
          return Center(
              child: Text("No Post Yet", style: TextStyle(fontSize: 18)));
        }
        List<PostCard> allposts = [];
        snapshot.data.docs.map((doc) {
          
          allposts.add(PostCard(
              post: Post(
                postID: doc.data()['postID'],
                postHeading: doc.data()['postHeading'],
                images: doc.data()['media'],
                postBody: doc.data()['postBody'],
                author: doc.data()['author'],
                isResolved: doc.data()['isResolved'],
                isLiked: doc.data()['isLiked'],
                isDisliked: doc.data()['isDisliked'],
                numberOfAttachment: doc.data()['numberOfAttachment'],
                numberOfComments: doc.data()['numberOfComments'],
                numberOfLikes: doc.data()['numberOfLikes'],
                numberOfDislikes: doc.data()['numberOfDislikes'],
              ),
              roomCode: roomCode));
        }).toList();
        return ListView(
          children: allposts,
        );
      },
    );
  }

  //showMembers
  showAllMembers(String roomId, String ownerId) {
    return StreamBuilder(
      stream: binCollection.doc(roomId).collection("members").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<Future<DocumentSnapshot>> collFuture = List();

        snapshot.data.docs.forEach((doc) {
          if (doc.id != ownerId) {
            collFuture.add(userCollection.doc(doc.id).get());
          }
        });

        return FutureBuilder<List<DocumentSnapshot>>(
          future: Future.wait<DocumentSnapshot>(collFuture),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserTile> allMembers = [];
              snapshot.data.forEach((docSnap) {
                allMembers.add(
                  UserTile(
                      user: MyUser(
                          uid: docSnap.id,
                          displayName: docSnap.data()['displayName'],
                          email: docSnap.data()['email'],
                          photoURL: docSnap.data()['circleAvatar'],
                          userName: docSnap.data()['userName']),
                      ownerId: ownerId,
                      code: roomId),
                );
              });
              return Column(children: allMembers);
            } else {
              return Container(
                child: Loading(),
              );
            }
          },
        );
      },
    );
  }

  Future addPost(
    String postID,
    String postHeading,
    String postBody,
    String author,
    List<File> images,
    bool isResolved,
    bool isLiked,
    bool isDisliked,
    int numberOfAttachment,
    int numberOfComments,
    int numberOfLikes,
    int numberOfDislikes,
  ) async {
    List<String> media = new List(numberOfAttachment);
    for (int i = 0; i < numberOfAttachment; i++) {
      var image = await compressImage(images.elementAt(i), postID);
      var let = await uploadImage(image, i, postID);
      media[i] = let;
    }

    await binCollection.doc(roomCode).collection('posts').doc(postID).set({
      "postID": postID,
      "postHeading": postHeading,
      "postBody": postBody,
      "author": author,
      "isResolved": isResolved,
      "isLiked": isLiked,
      "isDisliked": isDisliked,
      "media": media,
      "numberOfAttachment": numberOfAttachment,
      "numberOfComments": numberOfComments,
      "numberOfLikes": numberOfLikes,
      "numberOfDislikes": numberOfDislikes,
    });


  }

  //edit post
  Future<Post> editPost(String postId,String head,String des,List<File> img1,List<dynamic> img2)async{
    for (int i = 0; i < img1.length; i++) {
      var image = await compressImage(img1.elementAt(i), postId);
      var let = await uploadImage(image, i, postId);
      img2.add(let);
    }
    
    await binCollection.doc(roomCode).collection('posts').doc(postId).update({
      "postHeading": head,
      "postBody": des,
      "media": img2,
      "numberOfAttachment":img2.length,
    });
    DocumentSnapshot doc = await binCollection.doc(roomCode).collection('posts').doc(postId).get();
    Post post = Post(
                postID: doc.data()['postID'],
                postHeading: doc.data()['postHeading'],
                images: doc.data()['media'],
                postBody: doc.data()['postBody'],
                author: doc.data()['author'],
                isResolved: doc.data()['isResolved'],
                numberOfAttachment: doc.data()['numberOfAttachment'],
                numberOfComments: doc.data()['numberOfComments'],
                numberOfLikes: doc.data()['numberOfLikes'],
                numberOfDislikes: doc.data()['numberOfDislikes'],
              );
    return post;
  } 

  //fn to make doubt resolved
  Future<void> makeResolved(String postId) async {
    await binCollection
        .doc(roomCode)
        .collection("posts")
        .doc(postId)
        .update({"isResolved": true});
  }

  //fn to make doubt unresolved
  Future<void> makeUnResolved(String postId) async {
    await binCollection
        .doc(roomCode)
        .collection("posts")
        .doc(postId)
        .update({"isResolved": false});
  }

  //fn to delete post
  Future<void> deletePost(String postId, List<dynamic> images) async {
    await binCollection.doc(roomCode).collection("posts").doc(postId).delete();
    for (int i = 0; i < images.length; i++) {
      deleteImageFromStorage(images[i]);
    }
  }

  Future<void> deleteImageFromStorage(dynamic image)async{
     StorageReference ref =  await FirebaseStorage.instance.getReferenceFromUrl(image);
      ref.delete();
  }

  //exit a person from group
//room will be removed from his joined collection and
//he will be removed from member collection of that room

  exitFromBin(code, uid) async {
    await userRef.doc(uid).collection("joinedRoom").doc(code).delete();
    await binCollection.doc(code).collection('members').doc(uid).delete();
  }


  //likes post
  Future PostLikes(String postId) async {

    DocumentSnapshot  post =  await binCollection.doc(roomCode).collection("posts").doc(postId).get();
    int like = post.get('numberOfLikes');
    int disLike = post.get('numberOfDislikes');
    if(post.get('isLiked')==true){
      await binCollection.doc(roomCode).collection("posts").doc(postId).update({"numberOfLikes": like-1});
      await binCollection.doc(roomCode).collection("posts").doc(postId).update({"isLiked": false});
    }else{
      await binCollection.doc(roomCode).collection("posts").doc(postId).update({"numberOfLikes": like+1});
      await binCollection.doc(roomCode).collection("posts").doc(postId).update({"isLiked": true});
      if(post.get('isDisliked')==true){
        await binCollection.doc(roomCode).collection("posts").doc(postId).update({"numberOfDislikes": disLike-1});
        await binCollection.doc(roomCode).collection("posts").doc(postId).update({"isDisliked": false});
      }
    }
  }

  Future PostDislikes(String postId) async {
    DocumentSnapshot post = await binCollection.doc(roomCode).collection(
        "posts").doc(postId).get();
    int like = post.get('numberOfLikes');
    int disLike = post.get('numberOfDislikes');
    if (post.get('isDisliked') == true) {
      await binCollection.doc(roomCode).collection("posts").doc(postId).update(
          {"numberOfDislikes": disLike - 1});
      await binCollection.doc(roomCode).collection("posts").doc(postId).update(
          {"isDisliked": false});
    } else {
      await binCollection.doc(roomCode).collection("posts").doc(postId).update(
          {"numberOfDislikes": disLike + 1});
      await binCollection.doc(roomCode).collection("posts").doc(postId).update(
          {"isDisliked": true});
      if (post.get('isLiked') == true) {
        await binCollection.doc(roomCode).collection("posts")
            .doc(postId)
            .update({"numberOfLikes": like - 1});
        await binCollection.doc(roomCode).collection("posts")
            .doc(postId)
            .update({"isLiked": false});
      }
    }
  }

  addComments(String postId, String roomId, commentMap )
  {
    FirebaseFirestore.instance.collection("bins")
        .doc(roomId)
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .add(commentMap).catchError((e){print(e.toString());});
  }

  getComments(String roomId, String postId) async
  {
    return await FirebaseFirestore.instance.collection("bins")
        .doc(roomId)
        .collection("posts")
        .doc(postId)
        .collection("comments").orderBy("time", descending: true)
        .snapshots();
  }



}

Future compressImage(_image, postId) async {
  Directory temDir = await getTemporaryDirectory();
  final temPath = temDir.path;
  Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
  final compressImageFile = File('$temPath/img_$postId.jpg')
    ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
  _image = compressImageFile;
  return _image;
}

//this fn is responsible for uploading image
Future<String> uploadImage(_image, int i, postId) async {
  int id = new DateTime.now().millisecondsSinceEpoch;
  id+=i;
  StorageUploadTask uploadTask =
      storageRef.child('post$id _$postId.jpg').putFile(_image);
    
  StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
  String downloadURL = await storageSnap.ref.getDownloadURL();
  
  return downloadURL;
}
