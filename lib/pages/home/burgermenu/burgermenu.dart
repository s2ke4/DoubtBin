import 'package:doubtbin/pages/home/burgermenu/userinfo.dart';
import 'package:doubtbin/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BurgerMenu extends StatefulWidget {
  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              //height: 250,
              child: DrawerHeader(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      'DoubtBin',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    UserInfo(),
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: .7,
                    )
                  ],
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                children: <Widget> [
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
              alignment: Alignment.bottomLeft,
            ),
            FlatButton(
              onPressed: (){ _auth.signOutGoogle();},
              child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 9),
                      Text(
                        'Log Out',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ),
            )
          ],
        ),
      ),
    );
  }
}
