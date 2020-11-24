import 'package:doubtbin/model/bin.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';

class BurgerRoomTile extends StatelessWidget {
  final Bin bin;
  double pad = 70;
  double elevation = 4;

  BurgerRoomTile({this.bin});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        bin.binName,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoomDashboard(
                      roomCode: bin.roomId,
                      firstTime:
                          false, //true only when the user creates or joins the room and then visits it for first time
                      roomName: bin.binName,
                      description: bin.description,
                    )));
      },
    );
  }
}
