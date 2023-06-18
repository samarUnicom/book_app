import 'dart:convert';
import 'package:book_app/core/error/exceptions.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:flutter/services.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getAllBook();
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  int statusCode = 200;

  @override
  Future<List<BookModel>> getAllBook() async {
    if (statusCode == 200) {
      //read json file
      final jsondata =
          await rootBundle.rootBundle.loadString('jsonfile/books.json');
      //decode json data as list
      final decodedJson = json.decode(jsondata) as List<dynamic>;

      //map json and initialize using DataModel
      final List<BookModel> bookModels = decodedJson
          .map<BookModel>((json) => BookModel.fromJson(json))
          .toList();

      return bookModels;
    } else {
      throw ServerException();
    }
  }
}
