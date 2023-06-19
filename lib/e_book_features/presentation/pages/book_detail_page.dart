import 'package:book_app/core/util/snackbar_message.dart';
import 'package:book_app/e_book_features/data/datasources/user_data_source/user_local_data_source.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/presentation/widgets/books_page/add_rating_widget.dart';
import 'package:book_app/e_book_features/presentation/widgets/books_page/book_detail_header.dart';
import 'package:book_app/e_book_features/presentation/widgets/books_page/book_rate_starts.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:xid/xid.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../injection_container.dart';
import '../../data/models/commit_model.dart';
import '../../data/models/user_model.dart';
import '../bloc/commit/commit_bloc.dart';
import '../widgets/books_page/commit_card_widget.dart';
import '../widgets/books_page/message_display_widget.dart';
import '../widgets/books_page/text_button_widget.dart';

class BookDetailPage extends StatefulWidget {
  BookDetailPage({
    super.key,
    required this.book,
  });

  final BookModel book;
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final _formsendKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CommitBloc>(context)
        .add(GetBookCommitsEvent(book_id: widget.book.bookId!));
    focusNode.addListener(() {
      print('1:  ${focusNode.hasFocus}');
      BlocProvider.of<CommitBloc>(context)
          .add(GetBookCommitsEvent(book_id: widget.book.bookId!));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        minExtent: 40.h,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: _expandedWidget(
          context,
        ),
        expandedWidget: _expandedWidget(
          context,
        ),
        collapsed: true,
        backgroundWidget: buildCustomScrollView(context),
        duration: const Duration(milliseconds: 10),
        maxExtent: MediaQuery.of(context).size.height * 0.8,
        onDragging: (pos) {},
      ),
    );
  }

  Widget _expandedWidget(
    context,
  ) {
    TextEditingController _commetController = TextEditingController();

    return Material(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      elevation: 5,
      shadowColor: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(child: BlocBuilder<CommitBloc, CommitState>(
            builder: (context, state) {
              if (state is LoadingCommitState) {
                return LoadingWidget();
              } else if (state is LoadedCommitState) {
                print(state.commit.length);
                return state.commit.isEmpty
                    ? Center(
                        child: Text(" No Reviwes"),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: ListView.builder(
                            itemCount: state.commit.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return CommitCardWidget(
                                  commitModel: state.commit[index]);
                            }),
                      );
              } else if (state is ErrorCommitState) {
                return MessageDisplayWidget(message: state.message);
              }
              return LoadingWidget();
            },
          )),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: BlocConsumer<CommitBloc, CommitState>(
                    listener: (context, state) {
                  if (state is MessageAddCommitState) {
                    BlocProvider.of<CommitBloc>(context)
                        .add(GetBookCommitsEvent(book_id: widget.book.bookId!));
                    SnackBarMessage().showSuccessSnackBar(
                        message: state.message, context: context);
                  } else if (state is ErrorAddCommitState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: state.message, context: context);
                  }
                }, builder: (context, state) {
                  if (state is LoadingAddCommitState) {
                    return LoadingWidget();
                  }
                  return Form(
                    key: _formsendKey,
                    child: TextFormField(
                      controller: _commetController,
                      focusNode: focusNode,
                      validator: (val) =>
                          val!.isEmpty ? " Can't be empty" : null,
                      decoration: InputDecoration(
                        suffixIcon: MaterialButton(
                          color: Colors.deepPurpleAccent,
                          onPressed: () async {
                            UserModel c = await UserLocalDataSourceImpl(
                                    sharedPreferences: sl())
                                .getUser();
                            var xid = Xid();
                            var date = DateTime.now().toString();
                            var dateParse = DateTime.parse(date);
                            var formattedDate =
                                "${dateParse.day}-${dateParse.month}-${dateParse.year}";
                            final isValid =
                                _formsendKey.currentState!.validate();
                            print(formattedDate);
                            if (isValid) {
                              BlocProvider.of<CommitBloc>(context).add(
                                  AddCommitEvent(
                                      commitModel: CommitModel(
                                          commitId: "$xid",
                                          userId: c.userId,
                                          userImg: c.userImageUrl,
                                          userName: c.userName,
                                          bookId: widget.book.bookId,
                                          commit: _commetController.text,
                                          commitDate: "$formattedDate")));
                              _commetController.clear();
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          // backgroundColor: ColorConstant.lightBlueA100,
                          elevation: 0,
                        ),
                        hintText: "Add Reviwe...",
                        hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurpleAccent)),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: BookDetailHeaderDelegate(
            maximumExtent: kToolbarHeight * 5.5,
            minimumExtent: kToolbarHeight * 4,
            childBuilder: (percent) {
              return BookDetailHeader(
                book: widget.book,
                percent: percent,
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book Bio',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey[800],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: BookRateStars(
                                rate: widget.book.bookRating!,
                                heroTag: widget.book.bookName,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: CustomTextButton(
                        btn_text: "Rateing Book",
                        callBack: () {
                          modalBottomSheetMenu(context);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.book.bookBio!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2.h),
                Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
