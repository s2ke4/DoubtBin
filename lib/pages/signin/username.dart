import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home.dart';

class Username extends StatefulWidget {
  Function switchHomeAndUserName;
  Username(Function fn) {
    switchHomeAndUserName = fn;
  }
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
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
      await userRef.doc(_user.uid).set({
        "userName": userNameController.text.trim(),
        "displayName": _user.displayName,
        "email": _user.email,
        "circleAvatar": _user.photoURL,
        "uid": _user.uid
      });
      MyUser _newUser = MyUser(
          uid: _user.uid,
          photoURL: _user.photoURL,
          displayName: _user.displayName,
          email: _user.email,
          userName: userNameController.text.trim());
      widget.switchHomeAndUserName(_newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: appBar("DoubtBin"),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                SizedBox(height: 50),
                TextFormField(
                  onChanged: (val) {
                    setState(
                        () => correctUserName = val.length > 2 ? true : false);
                  },
                  controller: userNameController,
                  decoration: InputDecoration(
                      hintText: "Enter username",
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
          );
  }
}
