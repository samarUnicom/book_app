import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/data/models/rating_model.dart';
import 'package:book_app/e_book_features/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

import '../repositories/commit_repository.dart';
import '../repositories/rating_repository.dart';

class RatingUseCase {
  final RatingRepository repository;

  RatingUseCase(this.repository);

  Future<Either<Failure, RateModel>> call(int book_id) async {
    return await repository.getRate(book_id);
  }
}

class AddRatingUseCase {
  final RatingRepository repository;

  AddRatingUseCase(this.repository);

  Future<Either<Failure, Unit>> call(RateModel rateModel) async {
    return await repository.addRate(rateModel);
  }
}
