class commentModel{
  String comment;
  dynamic time;
  int numberOfLikes;
  int numberOfDislikes;
  String commentAuthor;
  Map likedUser;
  Map disLikedUser;

  commentModel({this.comment,this.time,this.numberOfDislikes,this.numberOfLikes,this.commentAuthor,this.likedUser,this.disLikedUser});
}