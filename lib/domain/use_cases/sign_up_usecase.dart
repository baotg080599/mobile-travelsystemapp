import 'package:room_finder_flutter/domain/entities/user_entity.dart';
import 'package:room_finder_flutter/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
