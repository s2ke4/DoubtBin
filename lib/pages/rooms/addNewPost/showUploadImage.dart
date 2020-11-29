import 'dart:io';

import 'package:doubtbin/pages/rooms/detailedImage.dart';
import 'package:flutter/material.dart';

class showImage extends StatelessWidget {
  List<File> images;
  Function RemoveImg;
  showImage({this.images,this.RemoveImg});

  @override
  Widget build(BuildContext context) {
    return (images.isEmpty)
            ?Text("no file selected")
            :GestureDetector(
                child:Stack(
                        children: [
                          Hero(
                              tag: "heroImage",
                              child: AspectRatio(
                                  aspectRatio: 0.85,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                        image:FileImage(images.elementAt(0)),
                                        fit:BoxFit.cover
                                      )
                                    ),
                                  ),
                              )
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom:0,
                            child: images.length>1?Opacity(
                              opacity: 0.6,
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                child:Text("+ ${images.length}",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),)
                              ),
                            ):Container(),
                          )
                        ],
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailedImage(imgs:images,isFileImage: true,removeImg:RemoveImg)));
                },
            );
  }
}
