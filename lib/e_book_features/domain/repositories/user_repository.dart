

import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, Unit>> storeUser(UserModel userModel);

}