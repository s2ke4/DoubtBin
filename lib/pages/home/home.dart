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
    Bin(
        owner: 'Ashish Phophalia & Novarun Deb',
        binName: 'CS201/CS261',
        color: 'Colors.red[200]'),
    Bin(
        owner: 'Naveen Kumar',
        binName: 'CS203/CS263',
        color: 'Colors.red[200]'),
    Bin(owner: 'Bhupendra Kumar', binName: 'MA201', color: 'Colors.red[200]'),
    Bin(
        owner: 'Kamal Kishor Jha',
        binName: 'EC201/EC261',
        color: 'Colors.red[200]'),
    Bin(
        owner: 'Dhirendra Kumar Sinha',
        binName: 'EE160',
        color: 'Colors.red[200]'),
    Bin(owner: 'Amandeep Singh', binName: 'HS201', color: 'Colors.red[200]'),
    Bin(owner: 'Vikas Kumar', binName: 'SC201', color: 'Colors.red[200]'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
