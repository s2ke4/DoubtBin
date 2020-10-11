import 'package:doubtbin/model/devs.dart';
import 'package:doubtbin/pages/aboutus/aboutudcard.dart';
import 'package:doubtbin/pages/home/burgermenu/burgermenu.dart';
import 'package:doubtbin/shared/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  List<Devs> devs = [
    Devs(name: "Abhay Dwividi", email: "abhaydwivedi230@gmail.com", buff: "Flutter | Javascript | Python | Firebase | Dart", description: "A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.", imgURL: "1.jpg", github: "https://github.com/dwivedi-abhay", linkedin: "https://www.linkedin.com/in/inayushpatel/"),
    Devs(name: "Ayush Patel", email: "in.ayushpatel@gmail.com", buff: "It's LONE.STAR", description: "A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.", imgURL:"2.jpg", github: "https://github.com/in-ayushpatel", linkedin: "https://www.linkedin.com/in/inayushpatel/"),
    Devs(name: "Darshan Devendra Hande", email: "darshanhande11@gmail.com", buff: "Flutter | Javascript | Python | Firebase | Dart | Java | C++ | HTML | CSS | C ", description: "A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentencgraphs add one idea at a time to your broader argument.", imgURL: "3.jpg", github: "https://github.com/darshanhande11", linkedin: "https://www.linkedin.com/in/darshan-hande-6a7479128/"),
    Devs(name: "Keshav Agarwal", email: "Keshavagarwal1710@gmail.com", buff: "Flutter | Javascript | Python | Firebase | Dart", description: "A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.", imgURL: "4.jpg", github: "https://github.com/The-Keshav-Agarwal", linkedin: "https://www.linkedin.com/in/keshav-agarwal-84b5221a9/"),
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
              child: Center(child: Text('About us', style: TextStyle(fontSize: 40),)),
            ),
            Column(
            children: devs.map((dev) => AboutUsCard(
                dev: dev,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
