import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/profile/profile.dart';


class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);
    String name = user.displayName.length>17?(user.displayName.substring(0,15)+"..."):user.displayName;

    return FlatButton(
      //color: Colors.blueAccent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())),
      child: Container(
        //color: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          children: <Widget>[
            Hero(
              tag: '$user.photoURL',
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(height: 7,),
                  Text(
                    user.email,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 14,
                        fontWeight: FontWeight.w200
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
