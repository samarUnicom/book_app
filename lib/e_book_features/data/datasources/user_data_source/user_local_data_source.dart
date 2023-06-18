import 'dart:convert';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser();
  Future<Unit> storeUser(UserModel userModel);
}

const USER_KEY = "USER";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> storeUser(UserModel userModel) {
    sharedPreferences.setString(USER_KEY, json.encode(userModel.toJson()));
    return Future.value(unit);
  }

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(USER_KEY);
    if (jsonString != null) {
      var decodeJsonData = json.decode(jsonString);

      return Future.value(UserModel.fromJson(decodeJsonData));
    } else {
      throw EmptyCacheException();
    }
  }
}
