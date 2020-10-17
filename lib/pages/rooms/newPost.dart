import 'dart:io';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doubtbin/services/room.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'dart:math';


class NewPost extends StatefulWidget {

  String roomCode;
  NewPost({this.roomCode});

  @override
  _NewPostState createState() => _NewPostState(roomCode: roomCode);
}

class _NewPostState extends State<NewPost> {

  String roomCode;
  _NewPostState({this.roomCode});


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
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  final _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));





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

//here is the connection
      final postID = getRandomString(10);
      final _user = Provider.of<MyUser>(context,listen:false);
      await BinDatabase(roomCode: roomCode,).addPost(
          postID, postHeadingController.text,
          postDescriptionController.text,
          _user.uid, false, 0, 0, 0, 0);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RoomDashboard(roomCode: roomCode, firstTime: true)));
      }
  }

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        RaisedButton(
                          onPressed: getImage,
                          color: Colors.blue[200],
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(height: 10.0),
                        _image == null
                            ? Text('No image selected.')
                            : Image.file(
                                _image,
                                height: 400,
                                width: 200,
                              )
                      ],
                    ),
                    //Add the code for file_picker here
                    Column(
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(allowMultiple: true);
                            if (result != null) {
                              files = result.paths
                                  .map((path) => File(path))
                                  .toList();
                            }
                            setState(() {
                              files != null
                                  // ignore: unnecessary_statements
                                  ? (attachment = true)
                                  // ignore: unnecessary_statements
                                  : (attachment = false);
                            });
                          },
                          color: Colors.blue[200],
                          child: Icon(Icons.attachment),
                        ),
                        //The code to view the files which are attached with the post can be viewed here
                        //I will write this code in a future update.
                        //But, our app is able to fetch files from the device file manager and attach it with the post.
                        SizedBox(
                          height: 10.0,
                        ),
                        files != null
                            ? (Icon(
                                Icons.image,
                                size: 120,
                              ))
                            : (Text('No files attached.'))
                      ],
                    ),
                  ],
                ),
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
