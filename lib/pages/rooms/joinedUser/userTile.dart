import 'package:doubtbin/model/user.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/detailedPost/deletePopUp.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final MyUser user;
  String ownerId,code;
  UserTile({this.user,this.code,this.ownerId});

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
          trailing: (ownerId==currentUser.uid && user.uid!=ownerId)?
                        GestureDetector(
                          child: Icon(Icons.exit_to_app),
                          onTap: ()async{
                            await deletePopUp(roomCode:code,isDeletePost: false,userId:user.uid).deletePost(context,"Are You Sure You Want to Remove ${user.displayName} From this Room","Remove");
                          },
                        )
                        :Text("")
        ),
      ),
    );
  }
}
