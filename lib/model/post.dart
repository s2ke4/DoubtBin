class Post {
  String postID;
  List<dynamic> images;
  String postHeading;
  String postBody;
  String author;
  bool isResolved;
  bool isLiked;
  bool isDisliked;
  int numberOfAttachment;
  int numberOfComments;
  int numberOfLikes;
  int numberOfDislikes;


  Post({
    this.postID,
    this.images,
    this.postHeading,
    this.postBody,
    this.author,
    this.isResolved,
    this.isLiked,
    this.isDisliked,
    this.numberOfAttachment,
    this.numberOfComments,
    this.numberOfLikes,
    this.numberOfDislikes,
  }); //named parameter

}
