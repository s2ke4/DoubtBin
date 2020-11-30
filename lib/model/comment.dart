class commentModel{
  String comment;
  dynamic time;
  int numberOfLikes;
  int numberOfDislikes;
  String commentAuthor;
  List<dynamic> liked;
  List<dynamic> disLiked;

  commentModel({this.comment,this.time,this.numberOfDislikes,this.numberOfLikes,this.commentAuthor});
}