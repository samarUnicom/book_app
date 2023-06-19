import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/domain/usecases/user_usecase.dart';
import 'package:book_app/e_book_features/presentation/bloc/book/book_bloc.dart';
import 'package:book_app/e_book_features/presentation/bloc/user/user_bloc.dart';
import 'package:book_app/e_book_features/presentation/pages/auth/login_page.dart';
import 'package:book_app/e_book_features/presentation/pages/spalsh_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'core/theme/app_theme.dart';
import 'e_book_features/data/datasources/commit_data_source/commit_remote_data_source.dart';
import 'e_book_features/presentation/bloc/commit/commit_bloc.dart';
import 'e_book_features/presentation/pages/books_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

List<CommitModel> data = [
  CommitModel(
      commitId: "2w",
      commit: "bay",
      userId: "1",
      userName: "ali",
      bookId: 1,
      commitDate: "21-03-2022",
      userImg:
          "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg"),
  CommitModel(
      commitId: "wq",
      commit: "hi",
      userId: "2",
      userName: "sarah",
      bookId: 1,
      commitDate: "21-03-2022",
      userImg:
          "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg")
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  di.sl<CommitBloc>()),
          BlocProvider(
              create: (_) => di.sl<BookBloc>()..add(GetAllBooksEvent())),
          BlocProvider(create: (_) => di.sl<UserBloc>()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: SpalshPage(),
          );
        }));
  }
}
