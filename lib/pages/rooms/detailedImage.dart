import 'package:cached_network_image/cached_network_image.dart';
import 'package:doubtbin/shared/loading.dart';
import 'package:flutter/material.dart';

class DetailedImage extends StatelessWidget {

  List<String> images;
  List<Hero> showImage;
  DetailedImage(List<String> imgs){
    images = imgs;
    showImage = images.map((image)=>Hero(
              tag: "heroImage",
              child: CachedNetworkImage(
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