import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/rooms/userTile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<MyUser>>(context) ?? [];
    List<UserTile> tile = [];
    for (int i = 0; i < users.length; i++) {
      tile.add(UserTile(
        user: users[i],
      ));
    }
    return Column(
      children: tile,
    );
  }
}
