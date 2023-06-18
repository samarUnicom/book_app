import 'package:book_app/e_book_features/data/datasources/user_data_source/user_local_data_source.dart';
import 'package:book_app/e_book_features/data/repositories/book_repository_imp.dart';
import 'package:book_app/e_book_features/data/repositories/user_repository_imp.dart';
import 'package:book_app/e_book_features/domain/repositories/book_repository.dart';
import 'package:book_app/e_book_features/domain/repositories/user_repository.dart';
import 'package:book_app/e_book_features/domain/usecases/book_usecase.dart';
import 'package:book_app/e_book_features/domain/usecases/commit_usecase.dart';
import 'package:book_app/e_book_features/domain/usecases/user_usecase.dart';
import 'package:book_app/e_book_features/presentation/bloc/book/book_bloc.dart';
import 'package:book_app/e_book_features/presentation/bloc/user/user_bloc.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'e_book_features/data/datasources/book_data_source/book_local_data_source.dart';
import 'e_book_features/data/datasources/book_data_source/book_remote_data_source.dart';
import 'e_book_features/data/datasources/commit_data_source/commit_local_data_source.dart';
import 'e_book_features/data/datasources/commit_data_source/commit_remote_data_source.dart';
import 'e_book_features/data/repositories/commit_repository_imp.dart';
import 'e_book_features/domain/repositories/commit_repository.dart';
import 'e_book_features/presentation/bloc/commit/commit_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => BookBloc(getAllBooks: sl()));
  sl.registerFactory(() => CommitBloc(
      getAllCommits: sl(), addCommitUseCase: sl(), initialCommitUseCase: sl()));
  sl.registerFactory(() => UserBloc(addUserUseCase: sl(), useCase: sl()));

// UseCases

  sl.registerLazySingleton(() => BookUseCase(sl()));
  sl.registerLazySingleton(() => CommitUseCase(sl()));
  sl.registerLazySingleton(() => UserUseCase(sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));
  sl.registerLazySingleton(() => AddCommitUseCase(sl()));
  sl.registerLazySingleton(() => InitialCommitUseCase(sl()));

// Repository

  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<CommitRepository>(() => CommitRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        localDataSource: sl(),
      ));

// DataSources

  sl.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl());

  sl.registerLazySingleton<CommitRemoteDataSource>(
      () => CommitRemoteDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<BookLocalDataSource>(
      () => BookLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<CommitLocalDataSource>(
      () => CommitLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
