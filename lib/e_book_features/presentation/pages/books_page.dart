import 'package:book_app/core/widgets/loading_widget.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:book_app/e_book_features/presentation/bloc/book/book_bloc.dart';
import 'package:book_app/e_book_features/presentation/widgets/books_page/book_list_widget.dart';
import 'package:book_app/e_book_features/presentation/widgets/books_page/message_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'base_page.dart';

class BookPage extends StatelessWidget {
   UserModel userModel;
  BookPage({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(page: _buildBody(),),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is LoadingBooksState) {
          return LoadingWidget();
        } else if (state is LoadedBooksState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: BooksListWidget(books: state.book,user: userModel,));
        } else if (state is ErrorBooksState) {
          return MessageDisplayWidget(message: state.message);
        }
        return LoadingWidget();
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<BookBloc>(context).add(RefreshBooksEvent());
  }
}
