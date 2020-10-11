import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);
    String name = user.displayName.length>17?(user.displayName.substring(0,15)+"..."):user.displayName;
    String email = user.email.length>28?(user.email.substring(0,23)+"..."):user.email;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
            radius: 25,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  email,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
