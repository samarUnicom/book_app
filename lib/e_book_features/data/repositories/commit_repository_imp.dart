import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/core/error/failures.dart';
import 'package:book_app/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/commit_repository.dart';
import '../datasources/commit_data_source/commit_local_data_source.dart';
import '../datasources/commit_data_source/commit_remote_data_source.dart';
import '../models/commit_model.dart';



class CommitRepositoryImpl implements CommitRepository {
  final CommitRemoteDataSource remoteDataSource;
  final CommitLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CommitRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CommitModel>>> getAllCommit(int book_id) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getAllCommit(book_id);
        localDataSource.cacheCommit(remote);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedCommit();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addCommit(CommitModel commitModel) async{
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addCommit(commitModel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> insertCommit(List<CommitModel> commits)async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addDumpCommit(commits);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else {
      return Left(ServerFailure());
    }
  }
}
