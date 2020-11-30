import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:doubtbin/pages/rooms/detailedPost/deletePopUp.dart';
import 'package:doubtbin/pages/rooms/editPost/editNewPost.dart';
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
  String roomOwner;
  _DetailPostState({this.post,this.roomCode});
  String userName,userImageURL,roomName='';
  bool isResolved=false;
  List<dynamic> liked = [];
  List<dynamic> disliked = [];
  int numberOfLikes;
  int numberOfDislikes;

  BinDatabase binDatabase = new BinDatabase();
  TextEditingController commentTextEditingController = new TextEditingController();


  void updateValue(Post post1){
    setState(()=>post = post1);
  }

  void removeNumberOfComment(){
    setState(()=>post.numberOfComments--);
  }

  @override
  void initState(){
    super.initState();
    getInfo();
    List<dynamic> liketemp;
    List<dynamic> disliketemp;
    post.liked == null ? liketemp = [] : liketemp = post.liked;
    post.liked == null ? disliketemp = [] : disliketemp = post.disliked;
    setState(() {
      isResolved = post.isResolved;
      liked = liketemp;
      disliked = disliketemp;
      numberOfLikes = post.numberOfLikes;
      numberOfDislikes = post.numberOfDislikes;
    });
  }

  getInfo()async{
    final val =await userRef.doc(post.author).get();
    final binref = await binCollection.doc(roomCode).get();
    setState((){
      userName = val.data()['userName'];
      userImageURL = val.data()['circleAvatar'];
      roomOwner = binref.data()['ownerId'];
      roomName = binref.data()['displayName'];
    });
  }

  //function to perform various operation such as like dislike delete resolved unresolved
  void performOperation(var result)async{
    switch(result){
      case WhyFarther.markAsResolved:
        setState(()=>isResolved = true);
        await BinDatabase(roomCode:roomCode).makeResolved(post.postID);
        break;
      case WhyFarther.markAsUnresolved:
        setState(()=>isResolved = false);
        await BinDatabase(roomCode:roomCode).makeUnResolved(post.postID);
        break;
      case WhyFarther.delete:
        await deletePopUp(roomCode:roomCode,postId:post.postID,images:post.images,isDeletePost:true).deletePost(context,"Delete this Doubt?","Delete");
        break;
      case WhyFarther.update:
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>EditNewPost(post:post,roomCode:roomCode,updateValue:updateValue)));
         break;
    }
  }

  void PostLike() async{
    liked.contains(currentUser.uid)==false ?
    setState(() {liked.add(currentUser.uid); if(disliked.contains(currentUser.uid) == true){numberOfDislikes--;disliked.remove(currentUser.uid);};numberOfLikes++; }) :
    setState(() {liked.remove(currentUser.uid); numberOfLikes--; });
    await BinDatabase(roomCode:roomCode).PostLikes(post.postID);
  }
  void PostDislike() async{
    disliked.contains(currentUser.uid)==false ?
    setState(() {disliked.add(currentUser.uid) ;if(liked.contains(currentUser.uid) == true){numberOfLikes--;liked.remove(currentUser.uid) ;};numberOfDislikes++; }) :
    setState(() {disliked.remove(currentUser.uid); numberOfDislikes--; });
    await BinDatabase(roomCode:roomCode).PostDislikes(post.postID);
  }

  void addComment() {
    String comm = commentTextEditingController.text.trim();
    if(comm.isNotEmpty){;
    setState(()=>post.numberOfComments++);
     binDatabase.addComments(post.postID, roomCode, comm,post.numberOfComments);
    setState(()=>commentTextEditingController.text = "");
     FocusScope.of(context).requestFocus(new FocusNode());
    }

  }

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
                              isResolved == true
                                ? (Icon(Icons.check,color: Colors.green[900],size: 30,))
                                : (Icon(Icons.access_time,color: Colors.red,size: 30,)),
                              (currentUser.uid==roomOwner || currentUser.uid==post.author)?
                              PopupMenuButton<WhyFarther>(
                                onSelected: (WhyFarther result) { performOperation(result); },
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
                                  isResolved == false?
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
                      post.images.isEmpty?Text(""):GestureDetector(
                        child: 
                        Stack(
                          children: [
                            Hero(
                              tag: "heroImage",
                              child: CachedNetworkImage(
                                fit:BoxFit.cover,
                                imageUrl: post.images[0],
                                placeholder: (context, url) => Loading(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom:0,
                              child: post.images.length>1?Opacity(
                                opacity: 0.6,
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child:Text("+ ${post.images.length}",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),)
                                ),
                              ) :Container(),
                            )
                          ],
                        ),
                        onTap: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(imgs:post.images,isFileImage:false)));
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children:[
                              IconButton(
                                icon: liked == null || liked.contains(currentUser.uid) == false ? Icon(Icons.thumb_up, size:27) : Icon(Icons.thumb_up,color: Colors.blue[500], size:27),
                                onPressed: PostLike,
                                splashColor: Colors.blue[100],
                                splashRadius: 25,
                              ),
                              SizedBox(width:10),
                              Text(numberOfLikes.toString()),
                              SizedBox(width:15),
                              IconButton(
                                icon: disliked == null || disliked.contains(currentUser.uid) == false ? Icon(Icons.thumb_down, size:27) : Icon(Icons.thumb_down,color: Colors.red[500], size:27),
                                onPressed: PostDislike,
                                splashColor: Colors.red[100],
                                splashRadius: 25,
                              ),
                              SizedBox(width:10),
                              Text(numberOfDislikes.toString())
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
             binDatabase.getComments(roomCode, post.postID,removeNumberOfComment),
             SizedBox(height:70)
             ]
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child:Container(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  controller: commentTextEditingController,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Write Your Comment...",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: addComment,
                        icon : Icon(Icons.send,color: Colors.blue,)),
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

