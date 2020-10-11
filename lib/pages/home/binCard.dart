import 'package:flutter/material.dart';
import '../../model/bin.dart';
import 'package:doubtbin/pages/rooms/roomDashboard.dart';

class BinCard extends StatelessWidget {
  final Bin bin;
  BinCard({this.bin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Card Clicked");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoomDashboard(
                      id: "123456789", //this we will fetch from firebase on linking backend
                      firstTime:
                          false, //true only when the user creates or joins the room and then visits it for first time
                      bin: bin,
                    )));
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>PostPage())),
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        elevation: 4.0,
        // color: ${bin.color}, isme error de rha hai
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                bin.binName,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 80.0),
              Text(
                bin.owner,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
