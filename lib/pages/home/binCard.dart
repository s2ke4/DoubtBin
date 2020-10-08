import 'package:flutter/material.dart';
import '../../model/bin.dart';

class BinCard extends StatelessWidget {
  final Bin bin;
  BinCard({this.bin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      elevation: 4.0,
      // color: ${bin.color}, isme error de rha hai
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              bin.binName,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 100.0),
            Text(
              bin.owner,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
