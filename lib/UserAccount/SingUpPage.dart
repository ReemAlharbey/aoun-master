// ignore: file_names

import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'LoggingPage.dart';

class SingUpPage extends StatefulWidget {
  SingUpPage({Key key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  @override
  Widget build(BuildContext context) {
    return  (
      Scaffold(
        body: Container(
          color: deepGreen,
         
          child: SingleChildScrollView(
            child: Center(
              child: Column(
              
                children: [
                  SizedBox(height: 80.h,),
                  
                  drowText(context, translatedData(context, "Create an account"), 18,color: white),
                   SizedBox(height: 20.h),
                  drowContiner(700, double.infinity, 0, 0,white, 
                  
                  Padding(
                    padding:  EdgeInsets.only(left:20.w,right: 40.w,top:40.h),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image(image: AssetImage("assets/image/logo.png"),height: 150.h,width: 150.w),
                        drowTextField(context, nameIcon, translatedData(context, "user name"),false, nameController, (val){}),
                        SizedBox(height: 10.h),
                        drowTextField(context, emailIcon,translatedData(context, "E-mail"),false, emailController, (val){}),
                        SizedBox(height: 10.h),
                        drowTextField(context, passIcon, translatedData(context, "password"),true, passController, (val){}),
                        SizedBox(height: 10.h),
                        drowTextField(context, iDIcon, translatedData(context, "Residence/ID number"),true, iDController, (val){}),
                        SizedBox(height: 10.h),
                        drowTextField(context, phoneIcon, translatedData(context, "Mobile number"),false, phoneController, (val){}),
                        SizedBox(height: 10.h),
                        drowButtoms(context,translatedData(context, "Create an account"), 12, white, (){},backgrounColor:deepGreen),
                        drowButtoms(context,translatedData(context, "Already have an account?Login"), 12, deepGreen, (){
                          goTopageReplacement(context, LoggingPage());
                        },backgrounColor:white)
                        ],
                    ),
                  ),
                  topRight: 90,
                  blur:10,
                  spShadow:3
                  )
                ],
              ),
            ),
          ),
        )
   ) );
  }
}
