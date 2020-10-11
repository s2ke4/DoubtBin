import 'package:doubtbin/pages/signin/username.dart';
import 'package:flutter/material.dart';
import 'burgermenu/burgermenu.dart';
import 'floatingactionbutton.dart';
import 'bin.dart';
import 'binCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Bin> bins = [
    Bin(owner: 'Ashish Phophalia & Novarun Deb', binName: 'CS201/CS261'),
    Bin(owner: 'Naveen Kumar', binName: 'CS203/CS263'),
    Bin(owner: 'Bhupendra Kumar', binName: 'MA201'),
    Bin(owner: 'Kamal Kishor Jha', binName: 'EC201/EC261'),
    Bin(owner: 'Dhirendra Kumar Sinha', binName: 'EE160'),
    Bin(owner: 'Amandeep Singh', binName: 'HS201'),
    Bin(owner: 'Vikas Kumar', binName: 'SC201'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Username()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12) ,
              child: Icon(Icons.person)),
          )
        ],
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
      ),
      drawer: BurgerMenu(),
      body: Column(
        children: bins
            .map((bin) => BinCard(
                  bin: bin,
                ))
            .toList(),
      ),
      floatingActionButton: FloatButton(),
    );
  }
}
