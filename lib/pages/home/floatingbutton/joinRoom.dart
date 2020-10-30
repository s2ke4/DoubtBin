import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';


class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController joinroomNameController = TextEditingController();
  bool validCode = true;
  bool isLoading = false;
  joinRoom()async{
    var code = joinroomNameController.text.trim();
    setState(()=>code.isEmpty?validCode = false:validCode = true);

    if(validCode)
    {
      setState(()=>isLoading = true);
      String name = await BinDatabase(roomCode:code).checkingCode(currentUser.uid);
      if(name==null){
        setState(()=>{validCode=false,isLoading = false});
      }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>RoomDashboard(firstTime:false,roomCode:code,roomName: name,)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[400], Colors.white],
            //transform: GradientRotation(pi/4),
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar("DoubtBin"),
        body: isLoading?Loading():Container(
          child:Padding(
            padding:EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height:50),
                TextFormField(
                  controller: joinroomNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText:"Enter Room Code",
                    border: OutlineInputBorder(),
                    labelText:"Room Code",
                    errorText: validCode?null:"Room Not Found, Please Enter Correct Code",
                  ),
                ),
                SizedBox(height:25),
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
                    ])),
                    child: Text("Join",style: TextStyle(color:Colors.white,fontSize:18),),
                  ),
                  onTap: joinRoom,
                )
              ],
            )
          )
        ),
      ),
    );
  }
}