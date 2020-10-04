import 'package:doubtbin/model/devs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class DevInfo extends StatelessWidget {

  final Devs dev;
  DevInfo({ @required this.dev });

  _github() async {
    final url = dev.github;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  _linkedin() async {
    final url = dev.linkedin;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  _launchURL() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: dev.email,
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.transparent,
//          elevation: 0,
//        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'location-${dev.imgURL}',
                    child: Image.asset(
                      'assets/${dev.imgURL}',
                      height: 360,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: MediaQuery.of(context).size.height*0.8,
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Text(dev.name,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,letterSpacing: 1.2,), textAlign: TextAlign.center,),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            child: Text(dev.buff,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,), textAlign: TextAlign.center,)
                          ),
                          SizedBox(height: 40,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                child: Icon(Icons.description),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        fit:FlexFit.loose,
                                        child: Text('About',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,)),
                                      ),
                                      SizedBox(height: 10,),
                                      Flexible(fit: FlexFit.loose, child: Text(dev.description, style: TextStyle(height: 1.7,fontSize: 12,color: Colors.grey[800]),textAlign: TextAlign.start,)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(20,0,30,0),
                                child: Icon(Icons.link),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Flexible(
                                        fit:FlexFit.loose,
                                        child: Text('Links',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,)),
                                      ),
                                      ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.fromLTRB(0,0,10,0),
                                        onTap: _launchURL,
                                        title: Text('Email'),
                                        trailing: Icon(Icons.email),
                                      ),
                                      ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.fromLTRB(0,0,10,0),
                                        onTap: _github,
                                        title: Text('Github'),
                                        trailing: Icon(Icons.category),
                                      ),
                                      ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.fromLTRB(0,0,10,0),
                                        onTap: _linkedin,
                                        title: Text('LinkedIn'),
                                        trailing: Icon(Icons.blur_linear),

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}