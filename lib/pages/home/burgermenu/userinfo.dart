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
      padding: const EdgeInsets.all(0),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          children: <Widget>[
            Hero(
              tag: '$user.photoURL',
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 25,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    user.email,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12,
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
