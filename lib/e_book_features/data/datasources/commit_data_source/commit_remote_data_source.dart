import 'dart:convert';
import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CommitRemoteDataSource {
  Future<List<CommitModel>> getAllCommit(int book_id);
  addCommit(CommitModel commitModel);
  addDumpCommit(List<CommitModel> commits);
}

const FILE_PATH = "file_path";

class CommitRemoteDataSourceImpl implements CommitRemoteDataSource {
  int statusCode = 200;
  final SharedPreferences sharedPreferences;
  CommitRemoteDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<CommitModel>> getAllCommit(int book_id) async {
    final jsonString = await sharedPreferences.getString(FILE_PATH);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      print("Loading list${decodeJsonData}");
      List<CommitModel> jsonToCommitModels = decodeJsonData
          .map<CommitModel>((json) => CommitModel.fromJson(json))
          .toList();
      List<CommitModel> book_commits = [];
      jsonToCommitModels.forEach((element) {
        if (book_id == element.bookId) {
          book_commits.add(element);
        }
      });
      print(book_id);
      print(book_commits.length);
      return Future.value(book_commits);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  addCommit(CommitModel commitModel) async {
    if (statusCode == 200) {
      CommitModel newCommitModel = CommitModel(
          commitId: commitModel.commitId,
          commit: commitModel.commit,
          userId: commitModel.userId,
          userName: commitModel.userName,
          bookId: commitModel.bookId,
          commitDate: commitModel.commitDate,
          userImg: commitModel.userImg);
      final jsonString = sharedPreferences.getString(FILE_PATH);
      final decodedJson = json.decode(jsonString!) as List<dynamic>;
      print("listBeforAdd${decodedJson}");
      final List<CommitModel> commitModels = decodedJson
          .map<CommitModel>((json) => CommitModel.fromJson(json))
          .toList();
      print(commitModels.length);
      commitModels.add(newCommitModel);
      print(commitModels.length);
      List bookModelsToJson = commitModels
          .map<Map<String, dynamic>>((CommitModel) => CommitModel.toJson())
          .toList();
      print(bookModelsToJson);
      await sharedPreferences.setString(
          FILE_PATH, json.encode(bookModelsToJson));

    } else {
      throw ServerException();
    }
  }

  @override
  addDumpCommit(List<CommitModel> commits) async {

    List commitModelsToJson =
        commits.map<Map<String, dynamic>>((model) => model.toJson()).toList();
    sharedPreferences.setString(FILE_PATH, json.encode(commitModelsToJson));
  }
}
