import 'package:room_finder_flutter/domain/entities/text_messsage_entity.dart';
import 'package:room_finder_flutter/domain/repositories/firebase_repository.dart';

class SendMyTextMessage {
  final FirebaseRepository repository;

  SendMyTextMessage({required this.repository});

  Future<void> call(
      TextMessageEntity textMessageEntity, String channelId) async {
    return await repository.sendTextMessage(textMessageEntity, channelId);
  }
}
