import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doubtbin/services/room.dart';

class Bin {
  String binName;
  String owner;
  String roomId;

  Bin({
    this.binName,
    this.owner,
    this.roomId
  }); //named parameter

  // factory Bin.fromDocument(doc)async{
  //         String roomId = doc.id;
  //         DocumentSnapshot bin =await binCollection.doc(roomId).get();
  //         String ownerName = bin.data()['ownerUserName'];
  //         String binName = bin.data()['rommName'];
  //         return Bin(
  //           binName: binName,
  //           owner: ownerName,
  //           roomId:roomId
  //         );
  // }


}
