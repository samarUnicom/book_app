import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../repositories/user_repository.dart';

class UserUseCase {
  final UserRepository repository;

  UserUseCase(this.repository);

  Future<Either<Failure, UserModel>> call() async {
    return await repository.getUser();
  }
}

class AddUserUseCase {
  final UserRepository repository;

  AddUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(UserModel userModel) async {
    return await repository.storeUser(userModel);
  }
}
