import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommitCardWidget extends StatelessWidget {
  CommitModel commitModel;
  CommitCardWidget({required this.commitModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 8.0, bottom: 8.sp),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(commitModel.userImg!),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(commitModel.userName!,
                          style: TextStyle(
                            height: 1.3,
                            color: Colors.black,
                            fontSize: 10.sp,
                          )),
                      Text(commitModel.commitDate!,
                          style: TextStyle(
                            height: 1.3,
                            color: Colors.grey[500],
                            fontSize: 8.sp,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(commitModel.commit!,
                  style: TextStyle(
                    height: 1.3,
                    color: Colors.grey[500],
                    fontSize: 8.sp,
                  )),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
