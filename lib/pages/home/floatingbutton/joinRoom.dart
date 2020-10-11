import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController joinroomNameController = TextEditingController();
  bool validCode = true;
  joinRoom(){
    setState(()=>joinroomNameController.text.trim().isEmpty?validCode = false:validCode = true);
    if(validCode)
    {
      //backend code to check code status
      if(validCode)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>RoomDashboard(firstTime:false,id:"122345")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("DoubtBin"),
      body: Container(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height:50),
              TextFormField(
                controller: joinroomNameController,
                decoration: InputDecoration(
                  hintText:"Enter Room Code",
                  border: OutlineInputBorder(),
                  labelText:"Room Code",
                  errorText: validCode?null:"Room Not Found, Please Enter Correct Code",
                ),
              ),
              SizedBox(height:100),
              RaisedButton(
                onPressed: joinRoom,
                child: Text("Join",style: TextStyle(color: Colors.white,fontSize: 18)),
                color: Colors.blue
              )
            ],
          )
        )
      ),
    );
  }
}