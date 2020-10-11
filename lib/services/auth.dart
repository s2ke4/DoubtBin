import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doubtbin/model/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;




  MyUser _userFromFirebase(User user){
      return user!=null?MyUser(uid:user.uid,photoURL: user.photoURL,displayName: user.displayName,email: user.email):null;
  }

  //stream for auth state change
  Stream<MyUser> get user{
      return _auth.authStateChanges().map(_userFromFirebase);   //.map((firebaseUser) => _userFromFirebase(firebaseUser)),
  }

  //code for signin with google goes here
  Future<String> singInWithGoogle() async{
    
    try{
      final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount.authentication;

      final AuthCredential _credential = GoogleAuthProvider.credential(
        accessToken:_googleSignInAuthentication.accessToken,
        idToken:_googleSignInAuthentication.idToken,
      );

      final UserCredential _authResult = await _auth.signInWithCredential(_credential);
      final User _user = _authResult.user;

      if(_user!=null)
      {
        assert(!_user.isAnonymous);
        assert(await _user.getIdToken()!=null);
        final User _currentUser = _auth.currentUser;
        assert(_user.uid==_currentUser.uid);
        print("sign in with google succed ");
        return '$_user';
      }
      return null;
    }catch(e){
      return null;
    }
  }

  //code for signout goes here
  Future signOutGoogle() async {
    try{
      print("User Signed Out");
      await _auth.signOut();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }catch(e){
        print("Error in signout");
        print(e.toString());
    }
  }
}