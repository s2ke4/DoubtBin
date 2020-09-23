import 'package:doubtbin/pages/home/burgermenu/userinfo.dart';
import 'package:provider/provider.dart';
import 'package:doubtbin/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BurgerMenu extends StatefulWidget {
  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return Container(
      child: Drawer(

        child: Column(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width/20),
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
                boxShadow: [BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.0,
                )],
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ListView(
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
          ],
        ),
      ),
    );
  }
}
