

import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

 class BookUseCase {
  final BookRepository repository;

  BookUseCase(this.repository);

  Future<Either<Failure, List<BookModel>>> call() async {
    return await repository.getAllBook();
  }
}