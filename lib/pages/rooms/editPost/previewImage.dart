import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/pages/rooms/editPost/showFullImage.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class PreViewImage extends StatelessWidget {

  List<File> img1;
  List<dynamic> img2;
  Function removeImage;

  PreViewImage({this.img1,this.img2,this.removeImage});

  @override
  Widget build(BuildContext context) {
    return (img1.isEmpty&&img2.isEmpty)
            ?Text("no file selected")
            :GestureDetector(
                child:Stack(
                        children: [
                          Hero(
                              tag: "heroImage",
                              child: img2.isEmpty?AspectRatio(
                                  aspectRatio: 0.85,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                        image:FileImage(img1.elementAt(0)),
                                        fit:BoxFit.cover
                                      )
                                    ),
                                  ),
                              ):
                              CachedNetworkImage(
                                fit:BoxFit.cover,
                                imageUrl: img2[0],
                                placeholder: (context, url) => Loading(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom:0,
                            child: (img1.length+img2.length)>1?Opacity(
                              opacity: 0.6,
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                child:Text("+ ${img1.length+img2.length}",style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),)
                              ),
                            ):Container(),
                          )
                        ],
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowFullImage(img1:img1,img2:img2,removeImg:removeImage)));
                },
            );
  }
}