import 'dart:ui' as ui;
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/presentation/widgets/cover_page_book.dart';
import 'package:flutter/material.dart';

class BookDetailHeader extends StatelessWidget {
  BookDetailHeader({super.key, this.percent, this.book});

  final double? percent;
  final BookModel? book;

  final ValueNotifier<bool> enableOpenBookAnimation = ValueNotifier(false);



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //-------------------------------
        // Blur background
        //-------------------------------
        Positioned.fill(
          bottom: 50,
          child: _BlurBackground(book: book, percent: percent),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              //--------------------------
              // Custom AppBar
              //--------------------------
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color:
                            ColorTween(begin: Colors.white, end: Colors.black)
                                .transform(percent!),
                        onPressed: () {
                          enableOpenBookAnimation.value = false;
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    //  ReadersRow(readers: book!.readers)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    //---------------------------
                    // Cover book image
                    //---------------------------
                    InkWell(
                      onTap: () => null,//_openBook(context),
                      child: Hero(
                        tag: book!.bookName!,
                        child: AspectRatio(
                          aspectRatio: .68,
                          child: CoverPageBook(srcImageBook: book!.bookImageUrl),
                        ),
                      ),
                    ),
                    //--------------------------
                    // Book details
                    //--------------------------
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            book!.bookName!,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: ColorTween(
                                        begin: Colors.white,
                                        end: Colors.black,
                                      ).transform(percent!),
                                      fontSize: ui.lerpDouble(22, 18, percent!),
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'By ${book!.bookAuthor}',
                            style: TextStyle(
                              color: ColorTween(
                                begin: Colors.white70,
                                end: Colors.grey,
                              ).transform(percent!),
                              fontSize: ui.lerpDouble(16, 14, percent!),
                              height: 1.7,
                            ),
                            maxLines: 1,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50 * percent!)
            ],
          ),
        )
      ],
    );
  }
}

// Blur
class _BlurBackground extends StatelessWidget {
  const _BlurBackground({
    required this.book,
    required this.percent,
  });

  final BookModel? book;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book!.bookImageUrl!),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10 * percent!)
        ],
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ColoredBox(
          color: ColorTween(begin: Colors.black26, end: Colors.white)
              .transform(percent!)!,
        ),
      ),
    );
  }
}


class BookDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  BookDetailHeaderDelegate({
    this.maximumExtent = kToolbarHeight * 2,
    this.minimumExtent = kToolbarHeight,
    required this.childBuilder,
  });

  final Widget Function(double) childBuilder;
  final double maximumExtent;
  final double minimumExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final percent = shrinkOffset / maxExtent;
    return childBuilder(percent);
  }

  @override
  double get maxExtent => maximumExtent;

  @override
  double get minExtent => minimumExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
