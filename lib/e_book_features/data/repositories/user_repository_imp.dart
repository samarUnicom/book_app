import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/core/error/failures.dart';
import 'package:book_app/core/network/network_info.dart';
import 'package:book_app/e_book_features/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/user_data_source/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {

  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      final remote = await localDataSource.getUser();
      return Right(remote);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> storeUser(UserModel userModel) async {
    try {
      await localDataSource.storeUser(userModel);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
