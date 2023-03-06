import 'package:room_finder_flutter/domain/entities/group_entity.dart';
import 'package:room_finder_flutter/domain/repositories/firebase_repository.dart';

class GetAllGroupsUseCase {
  final FirebaseRepository repository;

  GetAllGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call() {
    return repository.getGroups();
  }
}
