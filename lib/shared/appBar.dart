import 'package:flutter/material.dart';

AppBar appBar(String title){
  return AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[900]),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'AppBarFont',
              fontWeight: FontWeight.w600,
            ),
          ),
        );
}
