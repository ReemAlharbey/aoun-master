// ignore_for_file: missing_return

import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/AwesomDialog.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'LoggingPage.dart';

class SingUpPage extends StatefulWidget {
  SingUpPage({Key key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  GlobalKey<FormState> singUpKey = new GlobalKey();

  String notEmpty(String val) {
    if (val.isEmpty) {
      return translatedData(context, 'Fill in the field');
    }
  }

//-------------------------------------------------------------------
  String identity(String value) {
    if (value.isEmpty) {
      return translatedData(context, "Fill in the field");
    }
    if (value.length < 10 || value.length > 10) {
      return translatedData(context, 'The ID number must be 10 digits');
    }
  }

  String validPhone(String value) {
    if (value.isEmpty) {
      return translatedData(context, "Fill in the field");
    }
    if (value.length < 10 || value.length > 10) {
      return translatedData(context, 'The mobile number must be 10 digits');
    }
    if (!value.startsWith('05')) {
      return translatedData(context, 'Mobile number must start with 05');
    }
  }

  //-------------------------------
  String validEmail(String value) {
    if (value.trim().isEmpty) {
      return translatedData(context, "Fill in the field");
    }
    if (EmailValidator.validate(value.trim()) == false) {
      return translatedData(context, 'Invalid email');
    }
  }
  //-------------------------------------------------------------------

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
              drowText(
                  context, translatedData(context, "Create an account"), 18,
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
                      key: singUpKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image(image: AssetImage("assets/image/logo.png"),height: 150.h,width: 150.w),
                          drowTextField(
                            context,
                            nameIcon,
                            translatedData(context, "user name"),
                            false,
                            nameController,
                            notEmpty,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(
                                      r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                                  allow: true)
                            ],
                          ),
                          SizedBox(height: 10.h),
                          drowTextField(
                            context,
                            emailIcon,
                            translatedData(context, "E-mail"),
                            false,
                            emailController,
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
                            passController,
                            notEmpty,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.h),
                          drowTextField(
                            context,
                            iDIcon,
                            translatedData(context, "Residence/ID number"),
                            false,
                            iDController,
                            identity,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          SizedBox(height: 10.h),
                          drowTextField(
                            context,
                            phoneIcon,
                            translatedData(context, "Mobile number"),
                            false,
                            phoneController,
                            validPhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          SizedBox(height: 10.h),
                          drowButtoms(
                              context,
                              translatedData(context, "Create an account"),
                              12,
                              white, () {
                            singUp(
                                nameController.text,
                                emailController.text,
                                passController.text,
                                iDController.text,
                                phoneController.text);
                          }, backgrounColor: deepGreen),
                          drowButtoms(
                              context,
                              translatedData(
                                  context, "Already have an account?Login"),
                              12,
                              deepGreen, () {
                            goTopageReplacement(context, LoggingPage());
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

  singUp(String name, String email, String pass, String identity,
      String phone) async {
    FormState validData = singUpKey.currentState;
    if (validData.validate()) {
      try {
        //يتم اضافه المستخدم الي قاعده البيانات
        awesomDialog(context, 'Create an account', 'wating');

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: pass,
        );

        if (userCredential != null) {

        try {
            await FirebaseFirestore.instance.collection('user').add({
            "userID": userCredential.user.uid,
            'name': name,
            'emile': email,
            'pass': pass,
            'identity': identity,
            'phone': phone,
          })

              //التحقق ما اذا تمت العمليه بنجاح ام لا
              .then((value) {
            Navigator.pop(context);
            awesomDialog(
              context,
              "Process completed",
              "successfully",
            );
          }).catchError((e) {
            Navigator.pop(context);
            awesomDialog(
              context,
              "Connection error",
              "connectionError",
            );
          });
          
        }on FirebaseException catch (e) {
          print("-------------------------------------$e");
        }
        }


      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'weak-password') {
          awesomDialog(
            context,
            "Invalid password",
            "Weak password",
          );
        }
        else if (e.code == 'email-already-in-use') {
          awesomDialog(
            context,
            "Invalid email",
            "Email already in use",
          );
        } else {
          print("==============================================$e");
        }
      }
    }
  }
}
