import 'package:book_app/e_book_features/presentation/widgets/books_page/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

double rating = 0.0;
void modalBottomSheetMenu(context) {
  showModalBottomSheet(
      context: context,
      enableDrag: true,
      elevation: 2,
      showDragHandle: true,
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      builder: (builder) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color:
            Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'PLase Rating Book',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (ratingV) {
                            print(ratingV);
                            setState(() {
                              rating = ratingV;
                            });
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "${rating}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomTextButton(
                          btn_text: "Save Rate",
                          callBack: () {},
                        ),
                      ],
                    ))),
          );
        });
      });
}