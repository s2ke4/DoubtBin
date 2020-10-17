import 'package:doubtbin/model/post.dart';
import 'package:doubtbin/pages/rooms/postCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {

    final posts = Provider.of<List<Post>>(context)?? [];
    print("post length ");
    print(posts.length);

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index],);
      },
    );
  }
}
