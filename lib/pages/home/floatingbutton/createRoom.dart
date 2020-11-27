import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/services/room.dart';
import 'package:uuid/uuid.dart';
import '../home.dart';

var uuid = Uuid();


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
  bool isLoading = false;


  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future createRoom() async {
    String roomName = roomNameController.text.trim();
    String roomDescription = roomDescriptionController.text.trim();
    setState(()=>roomName.length > 50?toolong = true:toolong = false);
    setState(()=>roomDescription.length > 100?toolongDescription = true:toolong = false);
    setState(()=>roomName.isEmpty?tooShortName = true:tooShortName = false);
    if(!tooShortName && !toolong && !toolongDescription){
      //room
      setState(()=>isLoading = true);
      final roomCode = uuid.v4();
      await BinDatabase(roomCode: roomCode).createRoom(roomCode, roomName , roomDescription,);
      await BinDatabase(roomCode: roomCode).addmembers(currentUser.uid);
      await BinDatabase(roomCode: roomCode).joinRoom(currentUser.uid); 
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RoomDashboard(roomCode: roomCode,firstTime:true,roomName:roomName,description: roomDescription)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[100], Colors.white],
            //transform: GradientRotation(pi/4),
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar("Create Room"),
        body: isLoading?Loading():Container(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal:24),
            child: Column(
              children: [
                SizedBox(height:30),
                TextFormField(
                  controller: roomNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
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
                      filled: true,
                      fillColor: Colors.grey[50],
                    hintText:"Enter Room Description",
                    border: OutlineInputBorder(),
                    labelText:"Room Description",
                    errorText: toolongDescription?"Room Description too long":null),
                  ),
                SizedBox(height: 40),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(3.0, 3.0),
                          color: Colors.grey,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                        )
                      ],
                        gradient: LinearGradient(colors: [
                      const Color(0xff007EF4),
                      const Color(0xFF2A75BC),
                    ])
                    ),
                    child: Text("Create",style: TextStyle(color:Colors.white,fontSize:18),),
                  ),
                  onTap: createRoom,
                )
              ],
            )
          )
        ),
      ),
    );
  }
}