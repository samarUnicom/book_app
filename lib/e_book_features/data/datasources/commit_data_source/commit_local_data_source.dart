import 'dart:convert';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';

abstract class CommitLocalDataSource {
  Future<List<CommitModel>> getCachedCommit();
  Future<Unit> cacheCommit(List<CommitModel> commitModels);
}

const CACHED_COMMIT = "CACHED_COMMIT";

class CommitLocalDataSourceImpl implements CommitLocalDataSource {
  final SharedPreferences sharedPreferences;

  CommitLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheCommit(List<CommitModel> bookModels) {
    List bookModelsToJson = bookModels
        .map<Map<String, dynamic>>((bookModel) => bookModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_COMMIT, json.encode(bookModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CommitModel>> getCachedCommit() {
    final jsonString = sharedPreferences.getString(CACHED_COMMIT);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CommitModel> jsonToCommitModels = decodeJsonData
          .map<CommitModel>((json) => CommitModel.fromJson(json))
          .toList();
      return Future.value(jsonToCommitModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
