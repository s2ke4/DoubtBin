import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
            radius: 25,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.displayName,
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
    );
  }
}
