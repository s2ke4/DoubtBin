class Post {
  String postID;
  String postHeading;
  String postBody;
  String author;
  bool isResolved;
  int numberOfAttachment;
  int numberOfComments;
  int numberOfLikes;
  int numberOfDislikes;


  Post({
    this.postID,
    this.postHeading,
    this.postBody,
    this.author,
    this.isResolved,
    this.numberOfAttachment,
    this.numberOfComments,
    this.numberOfLikes,
    this.numberOfDislikes,
  }); //named parameter
}
