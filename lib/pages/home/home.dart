import 'package:doubtbin/shared/appBar.dart';
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
      appBar: appBar(),
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
