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
    if (statusCode == 200) {
      final jsondata = await rootBundle.rootBundle
          .loadString(sharedPreferences.getString(FILE_PATH)!);
      print(jsondata);
      final decodedJson = json.decode(jsondata) as List<dynamic>;

      final List<CommitModel> commitModels = decodedJson
          .map<CommitModel>((json) => CommitModel.fromJson(json))
          .toList();
      List<CommitModel> book_commits = [];
      commitModels.forEach((element) {
        if (book_id == element.bookId) {
          book_commits.add(element);
        }
      });
      print("ergsrsgtwgr${book_commits.length}");
      return book_commits;
    } else {
      throw ServerException();
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

      final jsondata = await rootBundle.rootBundle
          .loadString(sharedPreferences.getString(FILE_PATH)!);

      final decodedJson = json.decode(jsondata) as List<dynamic>;

      final List<CommitModel> commitModels = decodedJson
          .map<CommitModel>((json) => CommitModel.fromJson(json))
          .toList();
      print(commitModels.length);
      commitModels.add(newCommitModel);

      List bookModelsToJson = commitModels
          .map<Map<String, dynamic>>((CommitModel) => CommitModel.toJson())
          .toList();

      final filepath = sharedPreferences.getString(FILE_PATH);
      await File(filepath!).writeAsString(json.encode(bookModelsToJson));
      final jsondata2 = await rootBundle.rootBundle
          .loadString(sharedPreferences.getString(FILE_PATH)!);
      print(jsondata2);
    } else {
      throw ServerException();
    }
  }

  @override
  addDumpCommit(List<CommitModel> commits) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/commit_file.json');
    sharedPreferences.setString(
        FILE_PATH, "${directory.path}/commit_file.json");

    List bookModelsToJson = commits
        .map<Map<String, dynamic>>((bookModel) => bookModel.toJson())
        .toList();

    await file.writeAsString(json.encode(bookModelsToJson));
  }
}
