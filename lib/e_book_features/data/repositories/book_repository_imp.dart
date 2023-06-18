import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/core/error/failures.dart';
import 'package:book_app/core/network/network_info.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/book_data_source/book_local_data_source.dart';
import '../datasources/book_data_source/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<BookModel>>> getAllBook() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getAllBook();
        localDataSource.cacheBook(remote);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedBook();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
