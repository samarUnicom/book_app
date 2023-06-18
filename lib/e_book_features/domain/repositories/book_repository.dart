

import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookModel>>> getAllBook();
}