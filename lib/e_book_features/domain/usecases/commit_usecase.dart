

import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

import '../repositories/commit_repository.dart';

class CommitUseCase {
  final CommitRepository repository;

  CommitUseCase(this.repository);

  Future<Either<Failure, List<CommitModel>>> call(int book_id) async {
    return await repository.getAllCommit(book_id);
  }

}

class AddCommitUseCase {
  final CommitRepository repository;

  AddCommitUseCase(this.repository);

  Future<Either<Failure, Unit>> call(CommitModel commitModel) async {
    return await repository.addCommit(commitModel);
  }
}


class InitialCommitUseCase {
  final CommitRepository repository;

  InitialCommitUseCase(this.repository);

  Future<Either<Failure,Unit>> call(List<CommitModel> commits) async {
    return await repository.insertCommit(commits);
  }

}