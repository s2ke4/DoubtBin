import 'package:doubtbin/pages/rooms/newPost.dart';
import 'package:doubtbin/pages/rooms/postList.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDashboard extends StatefulWidget {
  final bool firstTime;
  final String roomCode;
  final String roomName;

  RoomDashboard({this.firstTime,  this.roomCode,this.roomName});

  @override
  _RoomDashboardState createState() =>
      _RoomDashboardState(firstTime: firstTime,roomCode: roomCode,roomName:roomName);
}

class _RoomDashboardState extends State<RoomDashboard> {
  final key = new GlobalKey<ScaffoldState>();
  bool firstTime;
  String roomCode;
  String roomName;

  _RoomDashboardState({this.firstTime, this.roomCode,this.roomName});

  //this list is created just for front-end, we will fetch the data from firebase and try to store it in a list so that the code remains the same.
//  List<Post> posts = [
//    Post(
//      author: 'Ashish Phophalia & Novarun Deb',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 1,
//      postHeading: 'Post Heading',
//      isResolved: false,
//      numberOfLikes: 10,
//      numberOfDislikes: 0,
//      numberOfComments: 21,
//    ),
//    Post(
//      author: 'Naveen Kumar',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 0,
//      postHeading: 'Post Heading',
//      isResolved: false,
//      numberOfLikes: 90,
//      numberOfDislikes: 20,
//      numberOfComments: 5,
//    ),
//    Post(
//      author: 'Bhupendra Kumar',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 3,
//      postHeading: 'Post Heading',
//      isResolved: true,
//      numberOfLikes: 0,
//      numberOfDislikes: 152,
//      numberOfComments: 16,
//    ),
//    Post(
//      author: 'Kamal Kishor Jha',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 4,
//      postHeading: 'Post Heading',
//      isResolved: true,
//      numberOfLikes: 0,
//      numberOfDislikes: 169,
//      numberOfComments: 9,
//    ),
//    Post(
//      author: 'Dhirendra Kumar Sinha',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 5,
//      postHeading: 'Post Heading',
//      isResolved: true,
//      numberOfLikes: 130,
//      numberOfDislikes: 70,
//      numberOfComments: 7,
//    ),
//    Post(
//      author: 'Amandeep Singh',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 3,
//      postHeading: 'Post Heading',
//      isResolved: true,
//      numberOfLikes: 100,
//      numberOfDislikes: 45,
//      numberOfComments: 4,
//    ),
//    Post(
//      author: 'Vikas Kumar',
//      postBody:
//          'This is a dummy post posted which should be two lines on the card. So now, is it two lines? This is a line written just to increase the number of words in the sentence.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et consequat ligula. Suspendisse leo felis, posuere ut turpis non, mollis efficitur orci. Suspendisse potenti. Phasellus imperdiet convallis turpis, vitae bibendum sem sodales sed. Duis nec semper enim. Morbi efficitur euismod elementum. In justo augue, varius sed tellus rhoncus, posuere posuere ligula. Duis a varius mauris. Duis et odio ipsum. Cras eget condimentum elit, in hendrerit nisl. Duis sed fringilla augue.',
//      numberOfAttachment: 0,
//      postHeading: 'Post Heading',
//      isResolved: true,
//      numberOfLikes: 62,
//      numberOfDislikes: 21,
//      numberOfComments: 1,
//    ),
//  ];

  @override
  void initState() {
    super.initState();
    if (firstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        "Copy Below Code And share with other to invite them"),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(roomCode,softWrap: true,)),
                        GestureDetector(
                          child: Icon(Icons.content_copy),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: roomCode));
                            key.currentState.showSnackBar(new SnackBar(
                              content: new Text("Copied to Clipboard"),
                            ));
                            Future.delayed(Duration(seconds: 2), () {
                              key.currentState.hideCurrentSnackBar();
                            });
                          },
                        )
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]
                  )
              );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar(
        roomName,
      ),
      body: BinDatabase(roomCode:roomCode).showAllPost(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost(roomCode: roomCode,roomName:roomName)));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
