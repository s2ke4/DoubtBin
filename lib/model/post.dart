class Post {
  String postID;
  List<dynamic> images;
  String postHeading;
  String postBody;
  String author;
  bool isResolved;
  List<dynamic> liked;
  List<dynamic> disliked;
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
    this.liked,
    this.disliked,
    this.numberOfAttachment,
    this.numberOfComments,
    this.numberOfLikes,
    this.numberOfDislikes,
  }); //named parameter

}
