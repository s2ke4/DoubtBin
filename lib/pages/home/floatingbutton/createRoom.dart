import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/services/room.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'dart:math';


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



  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

//  random string generate for room
  final _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future createRoom() async {

    setState(()=>roomNameController.text.trim().length > 50?toolong = true:toolong = false);
    setState(()=>roomDescriptionController.text.trim().length > 100?toolongDescription = true:toolong = false);
    setState(()=>roomNameController.text.trim().isEmpty?tooShortName = true:tooShortName = false);
    if(!tooShortName && !toolong && !toolongDescription){

//      room
      final roomCode = getRandomString(10);
      print(roomCode);
      final _user = Provider.of<MyUser>(context,listen:false);
      await BinDatabase(roomCode: roomCode).createRoom(roomCode, roomNameController.text , roomDescriptionController.text,);
      await BinDatabase(roomCode: roomCode).addmembers(_user.uid);

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RoomDashboard(roomCode: roomCode,firstTime:true)));
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