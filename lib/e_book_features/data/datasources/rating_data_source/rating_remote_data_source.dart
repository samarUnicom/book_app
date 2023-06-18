import 'dart:convert';
import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:io';
import 'dart:convert';

import '../../models/rating_model.dart';

abstract class RatingRemoteDataSource {
  Future<RateModel> getRating(int book_id);
  addRating(RateModel rateModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  int statusCode = 200;

  @override
  Future<RateModel> getRating(int book_id) async {
    if (statusCode == 200) {
      //read json file
      final jsondata =
          await rootBundle.rootBundle.loadString('jsonfile/book_rating.json');
      //decode json data as list
      final decodedJson = json.decode(jsondata) as List<dynamic>;

      //map json and initialize using DataModel
      final List<RateModel> rateing = decodedJson
          .map<RateModel>((json) => RateModel.fromJson(json))
          .toList();
      List<RateModel> book_rateing = [];
      rateing.forEach((element) {
        if (book_id == element.bookId) {
          book_rateing.add(element);
        }
      });
      return getAverageReviews(book_rateing);
    } else {
      throw ServerException();
    }
  }

  getAverageReviews(List<RateModel> book_rateing_list) async {
    num sumRates = 0;
    num ratesLength = 0;
    ratesLength = book_rateing_list.length;
    book_rateing_list.forEach((element) {
      sumRates += element.bookRating!;
    });
    return sumRates / ratesLength;
  }

  @override
  addRating(RateModel rateModel) async {
    if (statusCode == 200) {
      RateModel newRateModel = RateModel(
          bookId: rateModel.bookId,
          userId: rateModel.userId,
          bookRating: rateModel.bookRating);

      final file = File(('jsonfile/book_rating.json'));
      file.writeAsStringSync(json.encode(newRateModel.toJson()));
    } else {
      throw ServerException();
    }
  }
}
