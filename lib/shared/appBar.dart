import 'package:flutter/material.dart';

AppBar appBar(){
  return AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[900]),
          title: Text(
            "DoubtBin",
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
}
