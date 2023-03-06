import 'package:room_finder_flutter/domain/entities/text_messsage_entity.dart';
import 'package:room_finder_flutter/domain/repositories/firebase_repository.dart';

class GetMessageUseCase {
  final FirebaseRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
