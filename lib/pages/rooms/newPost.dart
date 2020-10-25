import 'dart:io';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doubtbin/services/room.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewPost extends StatefulWidget {

  String roomCode,roomName;
  NewPost({this.roomCode,this.roomName});

  @override
  _NewPostState createState() => _NewPostState(roomCode: roomCode,roomName:roomName);
}

class _NewPostState extends State<NewPost> {

  String roomCode,roomName;
  bool isLoading=false;
  _NewPostState({this.roomCode,this.roomName});

  TextEditingController postHeadingController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  bool tooLong = false;
  bool tooShortHeading = false;
  bool tooShortDescription = false;
  List<File> images =[];
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      }
    });
  }

  Future getImageFromGallery() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      }
    });
  }

  selectImage(parentContext){
    return showDialog(
      context:parentContext,
      builder:(context){
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child:Row(
                children:<Widget>[
                  Icon(Icons.camera_alt,size:25),
                  SizedBox(width:9),
                  Text("Image From Camera",style:TextStyle(fontSize: 17)),
                ]
              ),
              onPressed: ()=>getImageFromCamera()),
            SimpleDialogOption(
              child:Row(
                children:<Widget>[
                  Icon(Icons.photo,size:25),
                  SizedBox(width:9),
                  Text("Upload From Gallery",style:TextStyle(fontSize:17)),
                ]
              ),
              onPressed: ()=>getImageFromGallery(),),
            SimpleDialogOption(
              child:Row(
                children:<Widget>[
                  Icon(Icons.cancel,size:25),
                  SizedBox(width:9),
                  Text("Cancel",style:TextStyle(fontSize:17)),
                ]
              ),
              onPressed: (){Navigator.pop(context);},),
          ],
        );
      }
    );
  }

  showUploadImage(){
    return (images.isEmpty)
            ?Text("no file selected")
            :GestureDetector(
                child:Stack(
                        children: [
                          Hero(
                              tag: "heroImage",
                              child: AspectRatio(
                                  aspectRatio: 0.85,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                        image:FileImage(images.elementAt(0)),
                                        fit:BoxFit.cover
                                      )
                                    ),
                                  ),
                              )
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
                            ):Container(),
                          )
                        ],
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(images,true)));
                },
            );
  }

  Future newPost() async{
    setState(() => postHeadingController.text.trim().length > 50
        ? tooLong = true
        : tooLong = false);
    setState(() => postDescriptionController.text.trim().isEmpty
        ? tooShortDescription = true
        : tooShortDescription = false);
    setState(() => postHeadingController.text.trim().isEmpty
        ? tooShortHeading = true
        : tooShortHeading = false);
    if (!tooShortHeading && !tooLong && !tooShortDescription) {
      
      final postID =  uuid.v4();
      setState(()=>isLoading=true);
      await BinDatabase(roomCode: roomCode,).addPost(
          postID, postHeadingController.text,
          postDescriptionController.text,
          currentUser.uid,images, false, images.length, 0, 0, 0);
      Navigator.pop(context);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Loading():Scaffold(
        appBar: appBar("New Post"),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: postHeadingController,
                  decoration: InputDecoration(
                    hintText: "Enter the topic related to your doubt",
                    border: OutlineInputBorder(),
                    labelText: "Doubt Heading",
                    errorText: tooLong
                        ? "Post Heading is too long"
                        : (tooShortHeading
                            ? "Post Heading can't be empty"
                            : null),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: postDescriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText:
                        "Write your doubt, try to be specific and give appropriate details.",
                    border: OutlineInputBorder(),
                    labelText: "Doubt Description",
                    errorText: tooShortDescription
                        ? "Post Description can't be empty"
                        : (null),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text("Add Image",style: TextStyle(fontSize: 18)),
                  color: Colors.blue[200],
                  onPressed: ()=>selectImage(context),
                ),
                showUploadImage(),
                RaisedButton(
                  onPressed: newPost,
                  child:
                      Text("Create new Post", style: TextStyle(fontSize: 18)),
                  color: Colors.blue[200],
                ),
              ],
            ),
          ),
        )
    );
  }
}
