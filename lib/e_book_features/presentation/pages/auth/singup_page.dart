import 'package:book_app/core/theme/app_theme.dart';
import 'package:book_app/core/theme/colors.dart';
import 'package:book_app/core/util/snackbar_message.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:book_app/e_book_features/presentation/bloc/user/user_bloc.dart';
import 'package:book_app/e_book_features/presentation/pages/auth/login_page.dart';
import 'package:book_app/e_book_features/presentation/pages/books_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:xid/xid.dart';

import '../../../../injection_container.dart';

class SingupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                      Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                      Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "SingUp",
                  style: TextStyle(
                      color: ThemeColor.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 15))
                            ]),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: (val) =>
                                        val!.isEmpty ? " Can't be empty" : null,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) =>
                                        val!.isEmpty ? " Can't be empty" : null,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    validator: (val) =>
                                        val!.isEmpty ? " Can't be empty" : null,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    validator: (val) =>
                                        val!.isEmpty ? " Can't be empty" : null,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                        if (state is MessageStoreUserState) {
                          SnackBarMessage().showSuccessSnackBar(
                              message: state.message, context: context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        } else if (state is ErrorStoreUserState) {
                          SnackBarMessage().showErrorSnackBar(
                              message: state.message, context: context);
                        }
                      }, builder: (context, state) {
                        return InkWell(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  ThemeColor.secondaryColor,
                                  ThemeColor.primaryColor,
                                ])),
                            child: Center(
                              child: Text(
                                "SINGUP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              var xid = Xid();
                              BlocProvider.of<UserBloc>(context)
                                  .add(StoreUserEvent(
                                      userModel: UserModel(
                                userId: "$xid",
                                userName: _nameController.text,
                                userBio: "",
                                userConfirmPassword:
                                    _confirmPasswordController.text,
                                userEmail: _emailController.text,
                                userImageUrl:
                                    "https://img.freepik.com/premium-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg",
                                userPassword: _passwordController.text,
                              )));
                            }
                          },
                        );
                      }),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Do you have Acount?",
                          style: TextStyle(
                            color: ThemeColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
