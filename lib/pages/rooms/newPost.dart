import 'dart:io';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:file_picker/file_picker.dart';
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
  _NewPostState({this.roomCode,this.roomName});


  TextEditingController postHeadingController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  bool tooLong = false;
  bool tooShortHeading = false;
  bool tooShortDescription = false;
  bool attachment = false;
  /*variables for attachement*/
  File _image;
  List<File> files;
  final picker = ImagePicker();
  Future getImageFromCamera() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image=(File(pickedFile.path));
      }
    });
  }

  Future getImageFromGallery() async {

    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //print(File(pickedFile.path).runType);
    setState(() {
      if (pickedFile != null) {
        _image=(File(pickedFile.path));
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
    return (_image==null)?Text("no file selected"):
              GestureDetector(
                  child:Stack(
                          children: [
                            Hero(
                                tag: "heroImage",
                                child: Image.file(
                                        _image,
                                        height: 400,
                                        width:300
                                ),
                            ),
                            // Positioned(
                            //   left: 0,
                            //   right: 0,
                            //   top: 0,
                            //   bottom:0,
                            //   child: _image.length>1?Opacity(
                            //     opacity: 0.6,
                            //     child: Container(
                            //       color: Colors.white,
                            //       alignment: Alignment.center,
                            //       child:Text("+ ${_image.length}",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),)
                            //     ),
                            //   ) :Container(),
                            // )
                          ],
                        ),
                        onTap: (){
                          print("hello");
                          //FocusScope.of(context).requestFocus(new FocusNode());
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(_image)));
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
    print(tooLong);
    print(tooShortDescription);
    print(tooShortHeading);
    if (!tooShortHeading && !tooLong && !tooShortDescription) {

// //here is the connection
      final postID =  uuid.v4();
      await BinDatabase(roomCode: roomCode,).addPost(
          postID, postHeadingController.text,
          postDescriptionController.text,
          currentUser.uid, false, 0, 0, 0, 0);

      Navigator.pop(context);
      
      }
  }

  @override
  Widget build(BuildContext context) {
    //print(_image.length);
    return Scaffold(
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     // Column(
                //     //   children: [
                //     //     RaisedButton(
                //     //       onPressed: getImage,
                //     //       color: Colors.blue[200],
                //     //       child: Icon(Icons.add_a_photo),
                //     //     ),
                //     //     SizedBox(height: 10.0),
                //     //     _image == null
                //     //         ? Text('No image selected.')
                //     //         : Image.file(
                //     //             _image,
                //     //             height: 400,
                //     //             width: 200,
                //     //           )
                //     //   ],
                //     // ),
                //     //Add the code for file_picker here
                //     Column(
                //       children: [
                //         RaisedButton(
                //           onPressed: () async {
                //             FilePickerResult result = await FilePicker.platform
                //                 .pickFiles(allowMultiple: true);
                //             if (result != null) {
                //               files = result.paths
                //                   .map((path) => File(path))
                //                   .toList();
                //             }
                //             setState(() {
                //               files != null
                //                   // ignore: unnecessary_statements
                //                   ? (attachment = true)
                //                   // ignore: unnecessary_statements
                //                   : (attachment = false);
                //             });
                //           },
                //           color: Colors.blue[200],
                //           child: Icon(Icons.attachment),
                //         ),
                //         //The code to view the files which are attached with the post can be viewed here
                //         //I will write this code in a future update.
                //         //But, our app is able to fetch files from the device file manager and attach it with the post.
                //         SizedBox(
                //           height: 10.0,
                //         ),
                //         files != null
                //             ? (Icon(
                //                 Icons.image,
                //                 size: 120,
                //               ))
                //             : (Text('No files attached.'))
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: newPost,
                  child:
                      Text("Create new Post", style: TextStyle(fontSize: 18)),
                  color: Colors.blue[200],
                ),
              ],
            ),
          ),
        ));
  }
}
