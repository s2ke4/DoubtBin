import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class EditUsername extends StatefulWidget {
  String userName;
  Function fn;
  EditUsername({this.userName,this.fn});
  @override
  _EditUsernameState createState() => _EditUsernameState(userName);
}

class _EditUsernameState extends State<EditUsername> {
  TextEditingController userNameController = TextEditingController();
  bool correctUserName = true;
  bool isLoading = false;

  _EditUsernameState(String userName){
    userNameController.text = userName;
  }

  addUserInDatabase() async {
    if (userNameController.text.trim().length < 3) {
      setState(() => correctUserName = false);
    } else {
      setState(() {
        correctUserName = true;
        isLoading = true;
      });
      await userRef.doc(currentUser.uid).update({
        "userName": userNameController.text.trim(),
      });
      await widget.fn();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar("Edit Username"),
        body: isLoading?Loading():Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Hero(
                tag: '$currentUser.photoURL',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.photoURL),
                  radius: 50,
                ),
              ),
            ),
            SizedBox(height: 50),
            TextFormField(
              onChanged: (val) {
                setState(() => correctUserName = val.length > 2 ? true : false);
              },
              controller: userNameController,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "Enter new username",
                  labelText: "User Name",
                  errorText: correctUserName
                      ? null
                      : "user name must be atleast 3 character long",
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black54)),
            ),
            SizedBox(
              height: 25,
            ),
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
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              onTap: addUserInDatabase,
            )
          ]),
        ),
      ),
    );
  }
}
