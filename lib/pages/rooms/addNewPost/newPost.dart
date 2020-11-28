import 'dart:io';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/addNewPost/showUploadImage.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doubtbin/services/room.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewPost extends StatefulWidget {
  String roomCode, roomName;
  NewPost({this.roomCode, this.roomName});

  @override
  _NewPostState createState() =>
      _NewPostState(roomCode: roomCode, roomName: roomName);
}

class _NewPostState extends State<NewPost> {
  String roomCode, roomName;
  bool isLoading = false;
  TextEditingController postHeadingController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  bool tooLong = false;
  bool tooShortHeading = false;
  bool tooShortDescription = false;
  List<File> images = [];
  final picker = ImagePicker();

  _NewPostState({this.roomCode, this.roomName});

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

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                  child: Row(children: <Widget>[
                    Icon(Icons.camera_alt, size: 25),
                    SizedBox(width: 9),
                    Text("Image From Camera", style: TextStyle(fontSize: 17)),
                  ]),
                  onPressed: () => getImageFromCamera()),
              SimpleDialogOption(
                child: Row(children: <Widget>[
                  Icon(Icons.photo, size: 25),
                  SizedBox(width: 9),
                  Text("Upload From Gallery", style: TextStyle(fontSize: 17)),
                ]),
                onPressed: () => getImageFromGallery(),
              ),
              SimpleDialogOption(
                child: Row(children: <Widget>[
                  Icon(Icons.cancel, size: 25),
                  SizedBox(width: 9),
                  Text("Cancel", style: TextStyle(fontSize: 17)),
                ]),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void RemoveImage(img) {
    setState(() => images.remove(img));
  }

  Future newPost() async {
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
      setState(() => isLoading = true);
      final postID = uuid.v4();
      await BinDatabase(
        roomCode: roomCode,
      ).addPost(
          postID,
          postHeadingController.text.trim(),
          postDescriptionController.text.trim(),
          currentUser.uid,
          images,
          false,
          images.length,
          0,
          0,
          0);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("New Post"),
        body: isLoading
            ? Loading()
            : Container(
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
                        child: Text("Add Image",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        color: Color(0xff007EF4),
                        onPressed: () => selectImage(context),
                      ),
                      showImage(images: images, RemoveImg: RemoveImage),
                      RaisedButton(
                        onPressed: newPost,
                        child: Text("Create new Post",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        color: Color(0xff007EF4),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
