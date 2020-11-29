import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class DetailedImage extends StatefulWidget {

  // List<String> images;
  // List<File> fileImage;
  List<dynamic> imgs;
  bool isFileImage;
  Function removeImg;
  DetailedImage({this.imgs,this.isFileImage,this.removeImg});

  @override
  _DetailedImageState createState() => _DetailedImageState(
    imgs: imgs,
    isFileImage:isFileImage,
    removeImg: removeImg
  );
}

class _DetailedImageState extends State<DetailedImage> {
  final controller = PageController(
    initialPage:0,
  );

  List<dynamic> imgs;
  bool isFileImage;
  Function removeImg;
  _DetailedImageState({this.imgs,this.isFileImage,this.removeImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller:controller,
        children:imgs.map((image)=>Hero(
              tag: "heroImage",
              child: isFileImage?Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                        flex:11,
                        child: Container(
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              image:FileImage(image),
                              //fit:BoxFit.cover
                            )
                          ),
                    ),
                  ),
                  Flexible(
                    flex:1,
                    child:GestureDetector(
                      child: Icon(Icons.cancel,color: Colors.red,size:30),
                      onTap:(){
                        setState(()=>imgs.remove(image));
                        removeImg(image);
                        if(imgs.length==0){
                          Navigator.pop(context);
                        }
                      }
                    )
                  )
                ],
              ):CachedNetworkImage(
                                        imageUrl: image,
                                        placeholder: (context, url) => Loading(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
    )).toList(),
      )
    );
  }
}