

import 'package:book_app/core/error/failures.dart';
import 'package:book_app/e_book_features/data/models/rating_model.dart';
import 'package:dartz/dartz.dart';

abstract class RatingRepository {
  Future<Either<Failure, RateModel>> getRate(int book_id);
  Future<Either<Failure, Unit>> addRate(RateModel rateModel);
}