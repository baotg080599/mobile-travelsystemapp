import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_finder_flutter/constants/firestore_constants.dart.dart';
import 'package:room_finder_flutter/models/room_model.dart';

class RoomProvider {
  final FirebaseFirestore firebaseFirestore;

  RoomProvider({required this.firebaseFirestore});

  Stream<List<RoomChat>> getRooms() {
    final roomCollection = firebaseFirestore.collection('room');
    return roomCollection
        .orderBy(FirestoreConstants.createAt, descending: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => RoomChat.fromDocument(e)).toList());
  }

  Future<void> createRooms(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }
}
