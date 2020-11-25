import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/binCard.dart';
import 'package:doubtbin/pages/home/burgermenu/burgerRoomTile.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/joinedUsers.dart';
import 'package:doubtbin/pages/rooms/postCard.dart';
import 'package:doubtbin/pages/rooms/userTile.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

final CollectionReference binCollection =
    FirebaseFirestore.instance.collection('bins');
final StorageReference storageRef = FirebaseStorage.instance.ref();

class BinDatabase {
  final String roomCode;
  final String user;
  final String uid;
  BinDatabase({this.roomCode, this.user, this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
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

  Future createRoom(
      String roomCode, String displayName, String description) async {
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
                      description: docSnap.data()['description'],
                      binName: docSnap.data()['displayName'],
                      owner: docSnap.data()['ownerName'],
                      roomId: docSnap.id,
                    ),
                  ),
                );
              });

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

  //this is used to display the list of rooms in the burgermenu.
  showRoomsInBurger(String userId) {
    return StreamBuilder(
      stream: userRef.doc(userId).collection("joinedRoom").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
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

  //when a person joined a room then
  //we will include that person in the member collection of that room
  //we will include that room in the joined room collection of that person

  //check room code to join room
  checkingCode(String userId) async {
    bool found = false;
    String name;
    await binCollection.get().then((documents) {
      if (documents != null) {
        for (var doc in documents.docs) {
          if (doc.id == roomCode) {
            found = true;
            name = doc.data()['displayName'];
            break;
          }
        }
      }
    });
    if (found) {
      await userRef
          .doc(userId)
          .collection("joinedRoom")
          .doc(roomCode)
          .set({"joined": true});
      await binCollection
          .doc(roomCode)
          .collection("members")
          .doc(userId)
          .set({"member": true});
      return name;
    }
    return null;
  }

  //to get Description
  getDescription(String userId) async {
    bool found = false;
    String description;
    await binCollection.get().then((documents) {
      if (documents != null) {
        for (var doc in documents.docs) {
          if (doc.id == roomCode) {
            found = true;
            description = doc.data()['description'];
            break;
          }
        }
      }
    });
    if (found) {
      await userRef
          .doc(userId)
          .collection("joinedRoom")
          .doc(roomCode)
          .set({"joined": true});
      await binCollection
          .doc(roomCode)
          .collection("members")
          .doc(userId)
          .set({"member": true});
      return description;
    }
    return null;
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
  showAllMembers(String roomId) {
    return StreamBuilder(
      stream: binCollection.doc(roomId).collection("members").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Future<DocumentSnapshot>> collFuture = List();
        snapshot.data.docs.forEach((doc) {
          collFuture.add(userCollection.doc(doc.id).get());
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
                  ),
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
    int numberOfAttachment,
    int numberOfComments,
    int numberOfLikes,
    int numberOfDislikes,
  ) async {
    var media = new List(numberOfAttachment);
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
      "media": media,
      "numberOfAttachment": numberOfAttachment,
      "numberOfComments": numberOfComments,
      "numberOfLikes": numberOfLikes,
      "numberOfDislikes": numberOfDislikes,
    });
  }

  //get user list from snapshot
  List<MyUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUser(
          uid: doc.data()['uid'],
          displayName: doc.data()['displayName'],
          email: doc.data()['email'],
          photoURL: doc.data()['circleAvatar'],
          userName: doc.data()['userName']);
    }).toList();
  }

  //get user stream
  Stream<List<MyUser>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
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
      storageRef.child('post$i _$postId.jpg').delete();
    }
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
  StorageUploadTask uploadTask =
      storageRef.child('post$i _$postId.jpg').putFile(_image);
  StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
  String downloadURL = await storageSnap.ref.getDownloadURL();
  return downloadURL;
}
