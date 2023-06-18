import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:dartz/dartz.dart';

abstract class CommitRepository {
  Future<Either<Failure, List<CommitModel>>> getAllCommit(int book_id);
  Future<Either<Failure, Unit>> addCommit(CommitModel commitModel);
  Future<Either<Failure, Unit>> insertCommit(List<CommitModel> commits);
}