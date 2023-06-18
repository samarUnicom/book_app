import 'dart:convert';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getCachedBook();
  Future<Unit> cacheBook(List<BookModel> postModels);
}

const CACHED_BOOK = "CACHED_BOOK";

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheBook(List<BookModel> bookModels) {
    List bookModelsToJson = bookModels
        .map<Map<String, dynamic>>((bookModel) => bookModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_BOOK, json.encode(bookModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<BookModel>> getCachedBook() {
    final jsonString = sharedPreferences.getString(CACHED_BOOK);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<BookModel> jsonToBookModels = decodeJsonData
          .map<BookModel>((json) => BookModel.fromJson(json))
          .toList();
      return Future.value(jsonToBookModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
