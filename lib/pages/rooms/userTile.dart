import 'package:doubtbin/model/user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final MyUser user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Card(
        // margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${user.photoURL}'),
          ),
          title: Text(user.displayName),
          subtitle: Text('${user.userName}'),
        ),
      ),
    );
  }
}
