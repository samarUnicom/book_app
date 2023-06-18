import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/core/error/failures.dart';
import 'package:book_app/core/network/network_info.dart';
import 'package:book_app/e_book_features/data/models/rating_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/rating_repository.dart';
import '../datasources/rating_data_source/rating_remote_data_source.dart';
import '../models/commit_model.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RatingRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, RateModel>> getRate(int book_id) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getRating(book_id);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addRate(RateModel rateModel) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addRating(rateModel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
