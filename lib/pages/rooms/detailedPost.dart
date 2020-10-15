import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/pages/rooms/comment.dart';
import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

enum WhyFarther { delete, markAsResolved, markAsUnresolved, update }

class DetailPost extends StatefulWidget {

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  List<String> images = ["https://i.ytimg.com/vi/DJtL95DgsoM/maxresdefault.jpg"];
  var _selection;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar("Room Name"),
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
                          Row(
                            children:[
                              CircleAvatar(backgroundImage: AssetImage('assets/1.jpg'),radius: 17,),
                              SizedBox(width: 10,),
                              Text("Keshav",style: TextStyle(fontSize: 17),),
                              SizedBox(width: 10,),
                            ]
                          ),
                          Row(
                            children:[
                              Icon(Icons.access_time,color:Colors.red,size: 30,),
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
                                  PopupMenuItem<WhyFarther>(
                                    value: WhyFarther.markAsResolved,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Mark as Resolved'),
                                        Icon(Icons.check,color:Colors.green)
                                      ],
                                    ),
                                  ),
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
                                    value: WhyFarther.update,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Edit post'),
                                        Icon(Icons.edit)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]
                          )
                        ],
                      ),
                      Divider(),
                      Text("Post Heading",style:TextStyle(fontSize: 21,fontWeight: FontWeight.bold) ),
                      SizedBox(height:12),
                      Text("This is post body hello i have one doubt can u clear my doubt this is imp doubt this question is surely there on exam so please help me out to find the solution of this question any kind of help would be appreciated",
                          style: TextStyle(fontSize: 16,),),
                      SizedBox(height: 10),
                      GestureDetector(
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(images)));
                          
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
                              Text("20"),
                              SizedBox(width:15),
                              Icon(Icons.thumb_down,size:27),
                              SizedBox(width:10),
                              Text("20"),
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Row(
                              children:[
                                Icon(Icons.comment,size:27),
                                SizedBox(width:10),
                                Text("20"),
                              ]
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Comment(),
              Comment(),
              Comment(),
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