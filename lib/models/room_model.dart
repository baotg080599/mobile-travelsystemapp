import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_finder_flutter/constants/firestore_constants.dart.dart';

class RoomChat {
  String roomName;
  String createAt;
  String createdBy;
  List<String> memberIdList;
  String recentMessage;

  RoomChat({
    required this.roomName,
    required this.createAt,
    required this.createdBy,
    required this.memberIdList,
    required this.recentMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.roomName: this.roomName,
      FirestoreConstants.createAt: this.createAt,
      FirestoreConstants.createdBy: this.createdBy,
      FirestoreConstants.member: this.memberIdList,
      FirestoreConstants.recentMessage: this.recentMessage,
    };
  }

  factory RoomChat.fromDocument(DocumentSnapshot doc) {
    String roomName = doc.get(FirestoreConstants.roomName);
    String createAt = doc.get(FirestoreConstants.createAt);
    String createdBy = doc.get(FirestoreConstants.createdBy);
    List<String> memberIdList = doc.get(FirestoreConstants.member);
    String recentMessage = doc.get(FirestoreConstants.recentMessage);
    return RoomChat(
        roomName: roomName,
        createAt: createAt,
        createdBy: createdBy,
        memberIdList: memberIdList,
        recentMessage: recentMessage);
  }
}
