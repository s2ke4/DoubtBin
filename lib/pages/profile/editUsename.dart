import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUsername extends StatefulWidget {
  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  TextEditingController userNameController = TextEditingController();
  bool correctUserName = true;
  bool isLoading = false;

  addUserInDatabase() async {
    if (userNameController.text.trim().length < 3) {
      setState(() => correctUserName = false);
    } else {
      setState(() {
        correctUserName = true;
        isLoading = true;
      });
      final _user = Provider.of<MyUser>(context, listen: false);
      await userRef.doc(_user.uid).update({
        "userName": userNameController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar("Edit Username"),
        body: Container(
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
                  "Enter",
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
