import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doubtbin/services/auth.dart';

class SignButton extends StatelessWidget {
  final Function toggleLoading ;
  SignButton({this.toggleLoading});

  @override
  Widget build(BuildContext context) {

    final AuthServices _auth = AuthServices();

    return RawMaterialButton(
      shape: StadiumBorder(),
      onPressed: () async{
        toggleLoading();
        await _auth.singInWithGoogle();
      },
      fillColor: Colors.white,
      splashColor: Colors.grey,
      hoverElevation: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: Image(
              height:27,
              width: 27,
              image: NetworkImage('https://pngmind.com/wp-content/uploads/2019/08/Google-Logo-PNG-Transparent-Background.jpeg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: Text(
              'Sign-in with Google',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}