

import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:aoun/home/userHomePage/userHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SingUpPage.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({Key key}) : super(key: key);

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
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
                  
                  drowText(context,translatedData(context, "sign in"), 18,color: white),
                   SizedBox(height: 20.h),
                  drowContiner(700, double.infinity, 0, 0,white, 
                  
                  Padding(
                    padding:  EdgeInsets.only(left:20.w,right: 40.w,top:40.h),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                        drowTextField(context, emailIcon,  translatedData(context, "E-mail"),false, emailController, (val){}),
                        SizedBox(height: 10.h),
                        drowTextField(context, passIcon, translatedData(context, "password"),true, passController, (val){}),
                        SizedBox(height: 10.h),
                      
                        drowButtoms(context, translatedData(context, "sign in"), 12, white, (){goTopageReplacement(context, userHomePage());},backgrounColor:deepGreen),
                        drowButtoms(context, translatedData(context, "Don't have an account? Create an account"), 12, deepGreen, (){
                          goTopageReplacement(context, SingUpPage());
                        },backgrounColor:white)
                        ],
                    ),
                  ),
                  topRight: 90,
               
                  blur: 10,
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