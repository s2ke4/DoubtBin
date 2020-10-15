import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();
  bool tooShortName=false;
  bool toolong=false;
  bool toolongDescription=false;

  createRoom(){
    setState(()=>roomNameController.text.trim().length > 50?toolong = true:toolong = false);
    setState(()=>roomDescriptionController.text.trim().length > 100?toolongDescription = true:toolong = false);
    setState(()=>roomNameController.text.trim().isEmpty?tooShortName = true:tooShortName = false);
    if(!tooShortName && !toolong && !toolongDescription){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RoomDashboard(id:"123456789",firstTime:true)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("DoubtBin"),
      body: Container(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal:24),
          child: Column(
            children: [
              SizedBox(height:30),
              TextFormField(
                controller: roomNameController,
                decoration: InputDecoration(
                  hintText:"Enter Room Name",
                  border: OutlineInputBorder(),
                  labelText:"Room Name",
                  errorText: toolong?"Room Name too long":(tooShortName?"Room Name Can't Be Empty":null),
                ),
              ),
              SizedBox(height:40),
              TextFormField(
                controller: roomDescriptionController,
                decoration: InputDecoration(
                  hintText:"Enter Room Description",
                  border: OutlineInputBorder(),
                  labelText:"Room Description",
                  errorText: toolongDescription?"Room Description too long":null),
                ),
              SizedBox(height:25),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xff007EF4),
                    const Color(0xFF2A75BC),
                  ])),
                  child: Text("Create",style: TextStyle(color:Colors.white,fontSize:18),),
                ),
                onTap: createRoom,
              )
            ],
          )
        )
      ),
    );
  }
}