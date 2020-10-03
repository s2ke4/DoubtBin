import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDashboard extends StatefulWidget {
  bool firstTime;
  String id;
  RoomDashboard({this.id,this.firstTime});
  @override
  _RoomDashboardState createState() => _RoomDashboardState(id:id,firstTime:firstTime);
}

class _RoomDashboardState extends State<RoomDashboard> {
  final key = new GlobalKey<ScaffoldState>();
  bool firstTime;
  String id;
  _RoomDashboardState({this.id,this.firstTime});

  @override
  void initState() {
    super.initState();
    if(firstTime)
    {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) =>AlertDialog(
                title:Text("Copy Below Code And share with other to invite them"),
                content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(id),
                        GestureDetector(
                          child: Icon(Icons.content_copy),
                          onTap: (){
                            Clipboard.setData(new ClipboardData(text:id));
                            key.currentState.showSnackBar(
                            new SnackBar(content: new Text("Copied to Clipboard"),));
                            Future.delayed(Duration(seconds: 2), () { key.currentState.hideCurrentSnackBar(); });
                          },
                        )
                      ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[900]),
        title: Text("room Name",style: TextStyle(color:Colors.black),),
        backgroundColor: Colors.white,
      )
    );
  }
}
