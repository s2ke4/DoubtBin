import 'package:flutter/material.dart';
import 'bin.dart';

class BinCard extends StatelessWidget {
  final Bin bin;
  final Function delete;
  BinCard({this.bin, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                bin.binName,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Center(
              child: Text(
                bin.owner,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
