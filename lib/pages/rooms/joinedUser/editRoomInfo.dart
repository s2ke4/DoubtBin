import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class EditRoomInfo extends StatefulWidget {
  String roomName;
  String description;
  String roomCode;
  Bin bin;
  List<dynamic> domains;
  Function updateInfo;
  EditRoomInfo(
      {this.roomCode,
      this.roomName,
      this.description,
      this.domains,
      this.bin,
      this.updateInfo});
  @override
  _EditRoomInfoState createState() => _EditRoomInfoState(
      // roomCode: roomCode,
      // roomName: roomName,
      // description: description,
      // domains: domains,
      bin: bin,
      updateInfo: updateInfo);
}

class _EditRoomInfoState extends State<EditRoomInfo> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();
  TextEditingController roomDomainNameController = TextEditingController();
  bool tooShortName = false;
  bool toolong = false;
  bool toolongDescription = false;
  bool isLoading = false;
  // String roomName;
  // String description;
  // String roomCode;
  // List<dynamic> domains;
  Bin bin;
  Function updateInfo;
  _EditRoomInfoState(
      {
      // this.roomCode,
      // this.roomName,
      // this.description,
      // this.domains,
      this.bin,
      this.updateInfo}) {
    roomNameController.text = bin.binName;
    roomDescriptionController.text = bin.description;
    roomDomainNameController.text =
        bin.domain.toString().substring(1, bin.domain.toString().length - 1);
  }

  Future updateRoomInfo() async {
    String roomName = roomNameController.text.trim();
    String roomDescription = roomDescriptionController.text.trim();
    setState(() => roomName.length > 50 ? toolong = true : toolong = false);
    setState(() => roomDescription.length > 100
        ? toolongDescription = true
        : toolong = false);
    setState(
        () => roomName.isEmpty ? tooShortName = true : tooShortName = false);
    if (!tooShortName && !toolong && !toolongDescription) {
      var domainString = (roomDomainNameController.text).split(' ').join('');
      List domains = new List();
      if (domainString != "") {
        domains = domainString.split(',');
      }
      setState(() => isLoading = true);
      await binCollection.doc(bin.roomId).update({
        "displayName": roomName,
        "description": roomDescription,
        "domain": domains
      });
      updateInfo(roomName, roomDescription, domains);
      Navigator.pop(context);
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
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar("Edit Room Information"),
        body: isLoading
            ? Loading()
            : Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        TextFormField(
                          controller: roomNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            hintText: "Enter Room Name",
                            border: OutlineInputBorder(),
                            labelText: "Room Name",
                            errorText: toolong
                                ? "Room Name too long"
                                : (tooShortName
                                    ? "Room Name Can't Be Empty"
                                    : null),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: roomDescriptionController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[50],
                              hintText: "Enter Room Description",
                              border: OutlineInputBorder(),
                              labelText: "Room Description",
                              errorText: toolongDescription
                                  ? "Room Description too long"
                                  : null),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: roomDomainNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            hintText:
                                "Changing domain name won't affect already joined users.", //Changing domain name won't affect already joined users.
                            border: OutlineInputBorder(),
                            labelText: "Domain Name",
                          ),
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
                                ])),
                            child: Text(
                              "Save Changes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          onTap: updateRoomInfo,
                        )
                      ],
                    ))),
      ),
    );
  }
}
