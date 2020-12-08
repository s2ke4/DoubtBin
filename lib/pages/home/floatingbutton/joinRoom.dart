import 'package:doubtbin/pages/home/home.dart';
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
  bool notPermitted = false;
  bool isLoading = false;
  String notPermittedmsg = "You Are Not Permitted to join this room. Make Sure that you logged in with correct email id.";
  joinRoom() async {
    var code = joinroomNameController.text.trim();
    setState(() => code.isEmpty ? validCode = false : validCode = true);
    String email = currentUser.email;
    int i=0;
    while(email[i]!='@'){
      i++;
    }
    String currentDomain = email.substring(i+1);
    if (validCode) {
      setState(() => isLoading = true);
      String response =
          await BinDatabase(roomCode: code).checkingCode(currentUser.uid,context,currentDomain);
      if (response == "inValid Code") {
        setState(() => {validCode = false, isLoading = false});
      }else if(response == "notPermitted"){
        setState(() => {notPermitted = true, isLoading = false});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("DoubtBin"),
      body: isLoading
          ? Loading()
          : Container(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      TextFormField(
                        controller: joinroomNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: "Enter Room Code",
                          border: OutlineInputBorder(),
                          labelText: "Room Code",
                          errorMaxLines: 5,
                          errorText: validCode
                              ? (notPermitted?notPermittedmsg:null)
                              : "Room Not Found, Please Enter Correct Code",
                        ),
                      ),
                      SizedBox(height: 25),
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
                          child: Text(
                            "Join",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        onTap: joinRoom,
                      )
                    ],
                  ))),
    );
  }
}
