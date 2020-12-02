import 'package:doubtbin/model/devs.dart';
import 'package:doubtbin/pages/aboutus/aboutudcard.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Devs> devs = [
    Devs(
        name: "Abhay Dwivedi",
        email: "abhaydwivedi230@gmail.com",
        buff: "Flutter | Javascript | Python | Firebase | Dart",
        description: "We have tomorrows for a reason.",
        imgURL: "1.jpg",
        github: "https://github.com/dwivedi-abhay",
        linkedin: "https://www.linkedin.com"),
    Devs(
        name: "Ayush Patel",
        email: "in.ayushpatel@gmail.com",
        buff: "It's LONE.STAR",
        description: "Focusing my lens beyond the horizon",
        imgURL: "2.jpg",
        github: "https://github.com/in-ayushpatel",
        linkedin: "https://www.linkedin.com/in/inayushpatel/"),
    Devs(
        name: "Darshan Devendra Hande",
        email: "darshanhande11@gmail.com",
        buff: "Flutter | Java | Firebase | Dart | Python | C++ | C ",
        description:
            "If the world is a program, I am just a local variable with limited scope, memory and lifetime.",
        imgURL: "Darshan (2).jpg",
        github: "https://github.com/darshanhande11",
        linkedin: "https://www.linkedin.com/in/darshan-hande-6a7479128/"),
    Devs(
        name: "Keshav Agarwal",
        email: "Keshavagarwal1710@gmail.com",
        buff:
            "Flutter | c++ | Javascript | React | CSS | HTML | Firebase | Dart | c | java",
        description: "Just observing the world.",
        imgURL: "4.jpg",
        github: "https://github.com/The-Keshav-Agarwal",
        linkedin: "https://www.linkedin.com/in/keshav-agarwal-84b5221a9/"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("DoubtBin"),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(12),
              child: Center(
                  child: Text(
                'About us',
                style: TextStyle(fontSize: 40),
              )),
            ),
            Column(
              children: devs
                  .map((dev) => AboutUsCard(
                        dev: dev,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
