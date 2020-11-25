import 'package:doubtbin/pages/home/floatingbutton/createRoom.dart';
import 'package:doubtbin/pages/home/floatingbutton/joinRoom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpeedDial(
        marginBottom: 25,
        marginRight: 25,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 25.0),
        //child: Icon(Icons.add),
        visible: true,
        backgroundColor:Color(0xff007EF4),
        foregroundColor: Colors.white,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 6.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              backgroundColor: Colors.red,
              label: '  Join  ',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JoinRoom()))),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: 'Create',
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateRoom())),
          ),
        ],
      ),
    );
  }
}
