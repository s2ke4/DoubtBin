//<<<<<<< HEAD
import 'package:doubtbin/pages/signin/username.dart';
//=======
import 'package:doubtbin/shared/appBar.dart';
//>>>>>>> 9467871e390ac35c56abbddd1ef612c6995c492b
import 'package:flutter/material.dart';
import 'burgermenu/burgermenu.dart';
import 'floatingbutton/floatingactionbutton.dart';
import '../../model/bin.dart';
import 'binCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<Bin> bins = [
    Bin(
      owner: 'Ashish Phophalia & Novarun Deb',
      binName: 'CS201/CS261',
    ),
    Bin(
      owner: 'Naveen Kumar',
      binName: 'CS203/CS263',
    ),
    Bin(
      owner: 'Bhupendra Kumar',
      binName: 'MA201',
    ),
    Bin(
      owner: 'Kamal Kishor Jha',
      binName: 'EC201/EC261',
    ),
    Bin(
      owner: 'Dhirendra Kumar Sinha',
      binName: 'EE160',
    ),
    Bin(
      owner: 'Amandeep Singh',
      binName: 'HS201',
    ),
    Bin(
      owner: 'Vikas Kumar',
      binName: 'SC201',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//<<<<<<< HEAD
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
//=======
      appBar: appBar("DoubtBin"),
//>>>>>>> 9467871e390ac35c56abbddd1ef612c6995c492b
      drawer: BurgerMenu(),
      body: ListView(
        scrollDirection: Axis.vertical,
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
