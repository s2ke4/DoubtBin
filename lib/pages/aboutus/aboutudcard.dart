
import 'package:doubtbin/model/devs.dart';
import 'package:doubtbin/pages/aboutus/devinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {

  final Devs dev;

  AboutUsCard({this.dev});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 1,
      child: ListTile(
        onTap: () => Navigator.push(context,MaterialPageRoute(builder:(context)=>DevInfo(dev: dev))),
        contentPadding: EdgeInsets.all(10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(dev.name ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[800]), ),
            SizedBox(height: 5,),
            Text(dev.buff, style: TextStyle(height: 1.9, fontSize: 12, color: Colors.grey[700]),),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: 'location-${dev.imgURL}',
            child: Image.asset('assets/${dev.imgURL}',height: 50.0,),
          ),
        ),
      ),
    );
  }
}