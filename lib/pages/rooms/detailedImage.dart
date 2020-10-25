import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class DetailedImage extends StatelessWidget {

  // List<String> images;
  // List<File> fileImage;
  List<Hero> showImage;
  DetailedImage(List<dynamic> imgs,bool isFileImage){
    showImage = imgs.map((image)=>Hero(
              tag: "heroImage",
              child: isFileImage?Container(
                                      decoration: BoxDecoration(
                                        image:DecorationImage(
                                          image:FileImage(image),
                                          //fit:BoxFit.cover
                                        )
                                      ),
                                    ):CachedNetworkImage(
                                        imageUrl: image,
                                        placeholder: (context, url) => Loading(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
    )).toList();
  }

  final controller = PageController(
    initialPage:0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller:controller ,
        children: showImage,
        
      )
    );
  }
}