import 'package:doubtbin/model/bin.dart';
import 'package:doubtbin/pages/home/home.dart';
import 'package:doubtbin/pages/rooms/joinedUser/editRoomInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
}

class RoomInfo extends StatefulWidget {
  Bin bin;
  Function updateInfo2;
  RoomInfo({this.bin, this.updateInfo2});

  @override
  _RoomInfoState createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  final key = new GlobalKey<ScaffoldState>();

  handleCopyCode(BuildContext context) {
    Clipboard.setData(new ClipboardData(text: widget.bin.roomId));
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Copied to Clipboard'),
      ),
    );
  }

  void updateInfo(
      String binName, String binDescription, List<dynamic> binDomain) {
    setState(() {
      widget.bin.binName = binName;
      widget.bin.description = binDescription;
      widget.bin.domain = binDomain;
    });
    widget.updateInfo2(widget.bin);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: RIKeys.riKey1,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 30.0, 24.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(children: <Widget>[
              (currentUser.uid == widget.bin.ownerId)
                  ? Container(
                      alignment: Alignment.topRight,
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent, // button color
                          child: InkWell(
                            splashColor: Colors.blueGrey, // inkwell color
                            child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.edit,
                                  size: 25,
                                )),
                            onTap: () {
                              print(widget.bin.domain);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditRoomInfo(
                                            bin: widget.bin,
                                            updateInfo: updateInfo,
                                          )));
                            },
                          ),
                        ),
                      ))
                  : Container(),
              Container(
                child: Text(
                  widget.bin.binName,
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ]),
            SizedBox(height: 40),
            Text(
              widget.bin.description,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 40),
            Text("Joining Code : "),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Text(
                    widget.bin.roomId,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    child: Icon(Icons.content_copy),
                    onTap: () {
                      handleCopyCode(context);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
