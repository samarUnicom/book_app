import 'dart:async';

import 'package:book_app/core/theme/colors.dart';
import 'package:book_app/e_book_features/data/datasources/user_data_source/user_local_data_source.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:book_app/e_book_features/presentation/pages/auth/login_page.dart';
import 'package:book_app/e_book_features/presentation/pages/books_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection_container.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({Key? key}) : super(key: key);

  @override
  _SpalshPageState createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  final splashDelay = kDebugMode ? 6 : 6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: splashDelay), () async {
     try{
       UserModel c = await UserLocalDataSourceImpl(sharedPreferences: sl()).getUser();

       if (c != null) {
         if (c.userName != "" && c.userPassword != "") {
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (context) => BookPage(userModel: c,)));
         }
         return Future.value(null);
       } else {
         Navigator.of(context)
             .push(MaterialPageRoute(builder: (context) => LoginPage()));
       }
     }catch (e){
       Navigator.of(context)
           .push(MaterialPageRoute(builder: (context) => LoginPage()));
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
              ),
              child: Text("Book App"),
            )
          ],
        ),
      ),
    );
  }
}
