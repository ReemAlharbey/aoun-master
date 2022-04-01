import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:aoun/home/userHomePage/userHomePage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/AwesomDialog.dart';
import 'SingUpPage.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({Key key}) : super(key: key);

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  GlobalKey<FormState> loggingKey = new GlobalKey();
  //-------------------------------
  // ignore: missing_return
  String validEmail(String value) {
    if (value.trim().isEmpty) {
      return translatedData(context, "Fill in the field");
    }
    if (EmailValidator.validate(value.trim()) == false) {
      return translatedData(context, 'Invalid email');
    }
  }

  // ignore: missing_return
  String notEmpty(String val) {
    if (val.isEmpty) {
      return translatedData(context, 'Fill in the field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Container(
      color: deepGreen,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              drowText(context, translatedData(context, "sign in"), 18,
                  color: white),
              SizedBox(height: 20.h),
              drowContiner(
                  700,
                  double.infinity,
                  0,
                  0,
                  white,
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 40.w, top: 40.h),
                    child: Form(
                     key: loggingKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          drowTextField(
                            context,
                            emailIcon,
                            translatedData(context, "E-mail"),
                            false,
                            emailLogController,
                            validEmail,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-zA-Z]|[@]|[.]|[0-9]'),
                                  allow: true)
                            ],
                          ),
                          SizedBox(height: 10.h),
                          drowTextField(
                            context,
                            passIcon,
                            translatedData(context, "password"),
                            true,
                            passLogController,
                            notEmpty,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.h),
                          drowButtoms(context, translatedData(context, "sign in"),
                              12, white, () {
                            logging(
                                emailLogController.text, passLogController.text);
                          }, backgrounColor: deepGreen),
                          drowButtoms(
                              context,
                              translatedData(context,
                                  "Don't have an account? Create an account"),
                              12,
                              deepGreen, () {
                            goTopageReplacement(context, SingUpPage());
                          }, backgrounColor: white)
                        ],
                      ),
                    ),
                  ),
                  topRight: 90,
                  blur: 10,
                  spShadow: 3)
            ],
          ),
        ),
      ),
    )));
  }

  Future<void> logging(String emile, String pass) async {
    FormState validLogging = loggingKey.currentState;

    if (validLogging.validate()) {
      try {
        awesomDialog(context, 'sign in', 'wating');
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emile.trim(), password: pass);

        if (userCredential != null) {
          // Navigator.pop(context);
          goTopageReplacement(context, userHomePage());
        }
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        if (e.code == 'user-not-found') {
          awesomDialog(context, "Invalid data", "user not found");
        } else if (e.code == 'wrong-password') {
          awesomDialog(context, "Invalid data", "user not found");
        }
      }
    } else {
      awesomDialog(context, "Invalid data", "Verify");
    }
  }
}
