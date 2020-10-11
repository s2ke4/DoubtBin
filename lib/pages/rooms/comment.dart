import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:10,top: 15,right: 5),
      child: Bubble(
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(240, 240, 240, 1.0),
              child:Padding(
                padding: const EdgeInsets.fromLTRB(5,5,0,5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[
                        CircleAvatar(backgroundImage: AssetImage('assets/1.jpg'),radius: 16,),
                        SizedBox(width: 10,),
                        Text("Keshav",style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    SizedBox(height:10),
                    Text("hi this is very good doubt i like this it should be resolved at the earliest",style:TextStyle(fontSize: 16)),
                    SizedBox(height: 13,),
                    Row(
                      children: [
                        Icon(Icons.thumb_up,size:20 ),
                        SizedBox(width: 5),
                        Text("17",style: TextStyle(fontSize: 12),),
                        SizedBox(width: 18),
                        Icon(Icons.thumb_down,size: 20,),
                        SizedBox(width: 5),
                        Text("17",style: TextStyle(fontSize: 12),)
                      ],
                    )
                  ],
                ),
              )
            ),
    );
      }
    }