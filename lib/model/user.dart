class MyUser{
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  String userName;

  MyUser({this.uid,this.displayName,this.email,this.photoURL,this.userName});

  factory MyUser.creatingUser(doc){
    return MyUser(
      uid: doc.data()['uid'],
      displayName: doc.data()['displayName'],
      email: doc.data()['email'],
      photoURL: doc.data()['circleAvatar'],
      userName:doc.data()['userName']
    );
  }

}