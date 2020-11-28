import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/services/room.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class ShowFullImage extends StatefulWidget {
  List<File> img1;
  List<dynamic> img2;
  Function removeImg;
  ShowFullImage({this.img1,this.img2,this.removeImg});

  @override
  _ShowFullImageState createState() => _ShowFullImageState(
    img1: img1,
    img2:img2,
    removeImg:removeImg
  );
}

class _ShowFullImageState extends State<ShowFullImage> {

  List<File> img1;
  List<dynamic> img2;
  Function removeImg;
  _ShowFullImageState({this.img1,this.img2,this.removeImg});

  final controller = PageController(
    initialPage:0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller:controller,
        children:img2.map((image)=>Hero(
              tag: "heroImage",
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Flexible(
                        flex: 20,
                        child: CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) => Loading(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.cancel,color: Colors.red,size:30),
                    onTap:(){
                      setState(()=>img2.remove(image));
                      BinDatabase().deleteImageFromStorage(image);
                      removeImg(false,image);
                      if(img1.isEmpty && img2.isEmpty){
                        Navigator.pop(context);
                      }
                    }
                  )
                ],
              )
              )).toList() + 
              img1.map((image)=>Hero(
                    tag: "heroImage",
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex:20,
                          child: Container(
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                image:FileImage(image),
                                //fit:BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.cancel,color: Colors.red,size:30),
                          onTap:(){
                            setState(()=>img1.remove(image));
                            removeImg(true,image);
                            if(img1.isEmpty && img2.isEmpty){
                              Navigator.pop(context);
                            }
                          }
                        )
                      ],
                    )
              )).toList(),
      )
    );
  }
}