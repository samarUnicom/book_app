import 'dart:ui' as ui;
import 'package:book_app/core/widgets/loading_widget.dart';
import 'package:book_app/e_book_features/data/datasources/user_data_source/user_local_data_source.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:book_app/e_book_features/presentation/bloc/commit/commit_bloc.dart';
import 'package:book_app/e_book_features/presentation/pages/book_detail_page.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../injection_container.dart';
import 'book_rate_starts.dart';
import 'book_readers_row.dart';
import 'message_display_widget.dart';

class BooksListWidget extends StatefulWidget {
  List<BookModel> books;
  UserModel user;
  BooksListWidget({required this.books, required this.user});

  @override
  BooksListWidgetState createState() => BooksListWidgetState();
}

class BooksListWidgetState extends State<BooksListWidget> {
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _scrollPercentNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollPercentNotifier = ValueNotifier(0);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    _scrollPercentNotifier.value = (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent)
        .clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----------------------------
      // Home App Bar
      //----------------------------
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: kToolbarHeight * 1.6,
        title: _HomeAppBar(widget.user),
        actions: [
          const SizedBox(width: 20),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.user.userImageUrl!),
            ),
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          //------------------------------
          // Books List View
          //------------------------------
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.books.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemBuilder: (context, index) {
                final book = widget.books[index];
                /* BlocProvider.of<CommitBloc>(context)
                    .add(GetAllCommitsEvent(book_id: book.bookId!));*/
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                              book: book,
                            )));
                  },
                  child: _HomeBookCard(book: book),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            //---------------------------
            // List Scroll Indicator
            //---------------------------
            child: Stack(
              children: [
                const Divider(color: Color(0xFFeaeaea)),
                ValueListenableBuilder<double>(
                  valueListenable: _scrollPercentNotifier,
                  builder: (context, double value, child) {
                    return Align(
                      alignment: Alignment(ui.lerpDouble(-1.0, 1.0, value)!, 0),
                      child: child,
                    );
                  },
                  child: const SizedBox(
                    width: 50,
                    child: Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  UserModel userModel;
  _HomeAppBar(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userModel.userName!, style: Theme.of(context).textTheme.subtitle2),
        const SizedBox(height: 8),
        Text(
          'We recommended the following books for you',
          style: Theme.of(context).textTheme.subtitle2,
          maxLines: 2,
        )
      ],
    );
  }
}

class _HomeBookCard extends StatelessWidget {
  _HomeBookCard({
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Hero(
            tag: book.bookName!,
            child: AspectRatio(
              aspectRatio: .7,
              child: Container(
                margin: const EdgeInsets.only(right: 40, bottom: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(book.bookImageUrl!),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(10, 10),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.bookName!,
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'By ${book.bookAuthor}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(height: 1.7),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: BookRateStars(
            rate: book.bookRating!,
            heroTag: book.bookName,
          ),
        ),
        buildCommit(context),
        SizedBox(height: 10.h),
      ],
    );
  }

  buildCommit(context) {
    BlocProvider.of<CommitBloc>(context)
        .add(GetBookCommitsEvent(book_id: book.bookId!));
    return BlocProvider(
        create: (context) => CommitBloc(
            getAllCommits: sl(),
            addCommitUseCase: sl(),
            initialCommitUseCase: sl())
          ..add(GetBookCommitsEvent(book_id: book.bookId!)),
        child: BlocBuilder<CommitBloc, CommitState>(
          builder: (context, state) {
            if (state is LoadingCommitState) {
              return LoadingWidget();
            } else if (state is LoadedCommitState) {
              return ReadersRow(readers: state.commit);
            } else if (state is ErrorCommitState) {
              return MessageDisplayWidget(message: state.message);
            }
            return LoadingWidget();
          },
        ));
  }
}
