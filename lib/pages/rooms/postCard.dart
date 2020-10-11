import 'package:doubtbin/model/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  PostCard({this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Card Clicked");
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    // CircleAvatar(
                    //   backgroundImage: AssetImage('assets/1.jpg'),
                    //   radius: 17,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // Text(
                    //   "Keshav",
                    //   style: TextStyle(fontSize: 17),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    /*here begins the condensed form of card*/
                    Text(post.postHeading,
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold)),
                  ]),
                  post.isResolved == true
                      ? (Icon(
                          Icons.check,
                          color: Colors.green[900],
                          size: 30,
                        ))
                      : (Icon(
                          Icons.access_time,
                          color: Colors.red,
                          size: 30,
                        )),
                ],
              ),
              Divider(),
              // Text("Post Heading",
              //     style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(
                post.postBody.length > 200
                    ? (post.postBody.substring(0, 196) + '....')
                    : post.postBody,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              // CachedNetworkImage(
              //   fit: BoxFit.cover,
              //   imageUrl:
              //       "https://media.cheggcdn.com/media%2F109%2F1098ff33-8a74-446f-bf49-348232f79c1b%2Fimage.png",
              //   placeholder: (context, url) => Loading(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              SizedBox(height: 10),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.thumb_up, size: 27),
                    SizedBox(width: 10),
                    Text(post.numberOfLikes.toString()),
                    SizedBox(width: 15),
                    Icon(Icons.thumb_down, size: 27),
                    SizedBox(width: 10),
                    Text(post.numberOfDislikes.toString()),
                    SizedBox(width: 15),
                    Icon(Icons.image, size: 27),
                    SizedBox(width: 10),
                    Text(post.numberOfAttachment.toString()),
                    // if(post.isAttachment)
                    // {
                    //   Icon(
                    //       Icons.check,
                    //       color: Colors.green[900],
                    //       size: 30,
                    //     )
                    // }
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(children: [
                      Icon(Icons.comment, size: 27),
                      SizedBox(width: 10),
                      Text(post.numberOfComments.toString()),
                    ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
