import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/comment.dart';
import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

enum WhyFarther { delete, markAsResolved, markAsUnresolved, update }

class DetailPost extends StatefulWidget {

  Post post;
  String roomCode;
  DetailPost({this.post,this.roomCode});
  @override
  _DetailPostState createState() => _DetailPostState(post:post,roomCode:roomCode);
}

class _DetailPostState extends State<DetailPost> {

  Post post;
  String roomCode;
  List<dynamic> images;
  String roomOwner;
  _DetailPostState({this.post,this.roomCode});
  String userName,userImageURL,roomName='';
  
  @override
  void initState(){
    super.initState();
    getInfo();
  }

  getInfo()async{
    final val =await userRef.doc(post.author).get();
    final binref = await binCollection.doc(roomCode).get();
    setState((){
      userName = val.data()['userName'];
      userImageURL = val.data()['circleAvatar'];
      images = post.images;
      roomOwner = binref.data()['ownerId'];
      roomName = binref.data()['displayName'];
    });
  }

  var _selection;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar(roomName),
      body: GestureDetector(
        onTap: (){ FocusScope.of(context).requestFocus(new FocusNode());},
        child: Stack(
          children: [
            ListView(
            children:[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          (userName==null||userImageURL==null)?Loading():Row(
                            children:[
                              CircleAvatar(backgroundImage: NetworkImage(userImageURL),radius: 17,),
                              SizedBox(width: 10,),
                              Text(userName,style: TextStyle(fontSize: 17),),
                              SizedBox(width: 10,),
                            ]
                          ),
                          Row(
                            children:[
                              post.isResolved == true
                                ? (Icon(Icons.check,color: Colors.green[900],size: 30,))
                                : (Icon(Icons.access_time,color: Colors.red,size: 30,)),
                              (currentUser.uid==roomOwner || currentUser.uid==post.author)?
                              PopupMenuButton<WhyFarther>(
                                onSelected: (WhyFarther result) { setState(() {  _selection = result;print(_selection); }); },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
                                  PopupMenuItem<WhyFarther>(
                                    value: WhyFarther.delete,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delete this post'),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  ),
                                  post.isResolved == false?
                                  PopupMenuItem<WhyFarther>(
                                    value: WhyFarther.markAsResolved,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Mark as Resolved'),
                                        Icon(Icons.check,color:Colors.green)
                                      ],
                                    ),
                                  ):
                                  PopupMenuItem<WhyFarther>(
                                    value: WhyFarther.markAsUnresolved,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Mark as Unresolved'),
                                        Icon(Icons.access_time,color:Colors.red)
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<WhyFarther>(
                                    value: (currentUser.uid==post.author)?WhyFarther.update:null,
                                    child: (currentUser.uid==post.author)?Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Edit post'),
                                        Icon(Icons.edit)
                                      ],
                                    ):null,
                                  ),
                                ],
                              ):Container()
                            ]
                          )
                        ],
                      ),
                      Divider(),
                      Text(post.postHeading,style:TextStyle(fontSize: 21,fontWeight: FontWeight.bold) ),
                      SizedBox(height:12),
                      Text(post.postBody,style: TextStyle(fontSize: 16,),),
                      SizedBox(height: 10),
                      images==null?Text(""):GestureDetector(
                        child: 
                        Stack(
                          children: [
                            Hero(
                                    tag: "heroImage",
                                    child: CachedNetworkImage(
                                      fit:BoxFit.cover,
                                      imageUrl: images[0],
                                      placeholder: (context, url) => Loading(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom:0,
                              child: images.length>1?Opacity(
                                opacity: 0.6,
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child:Text("+ ${images.length}",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),)
                                ),
                              ) :Container(),
                            )
                          ],
                        ),
                        onTap: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(images,false)));
                          
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children:[
                              Icon(Icons.thumb_up,size:27),
                              SizedBox(width:10),
                              Text(post.numberOfLikes.toString()),
                              SizedBox(width:15),
                              Icon(Icons.thumb_down,size:27),
                              SizedBox(width:10),
                              Text(post.numberOfDislikes.toString())
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Row(
                              children:[
                                Icon(Icons.comment,size:27),
                                SizedBox(width:10),
                                Text(post.numberOfComments.toString())
                              ]
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //comments will come here
              SizedBox(height:70)
             ]
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child:Container(
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Write Your Comment...",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.send,color: Colors.blue,),
                  ),
                ),
                decoration: new BoxDecoration (
                    color: Colors.white
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}