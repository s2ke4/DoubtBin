import 'dart:io';

import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/rooms/editPost/previewImage.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNewPost extends StatefulWidget {

  String roomCode;
  Post post;
  Function updateValue;

  EditNewPost({this.post,this.roomCode,this.updateValue});

  @override
  _EditNewPostState createState() => _EditNewPostState(
    post:post
  );
}

class _EditNewPostState extends State<EditNewPost> {

  
  TextEditingController postHeadingController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  Post post;
  String head,des;
  List<dynamic> img;
  List<File> images =[];
  final picker = ImagePicker();
  bool isLoading = false;
  bool tooLong = false;
  bool tooShortHeading = false;
  bool tooShortDescription = false;

  _EditNewPostState({this.post}){
    postHeadingController.text = post.postHeading;
    postDescriptionController.text = post.postBody;
    img = post.images;
  }


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

  void removeImg(bool isTypeFile,image){
    setState(()=>isTypeFile?images.remove(image):img.remove(image));
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

  Future editPost() async{
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
      setState(()=>isLoading=true);
      Post post1 = await BinDatabase(roomCode: widget.roomCode,).editPost(post.postID,postHeadingController.text.trim(),
      postDescriptionController.text.trim(),images,img);
      widget.updateValue(post1);
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Edit Post"),
        body: isLoading?Loading():Container(
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
               PreViewImage(img1:images,img2:img,removeImage: removeImg),
                RaisedButton(
                  onPressed: editPost,
                  child:
                      Text("Update Post", style: TextStyle(fontSize: 18)),
                  color: Colors.blue[200],
                ),
              ],
            ),
          ),
        )
    );
  }
}