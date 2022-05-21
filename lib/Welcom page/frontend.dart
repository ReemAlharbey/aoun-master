

import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/image.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(welcomImage,
            
            ),
            fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              children: [
            
                SizedBox(height: 50.h,),
                CircleAvatar(
                  radius:60,
                  backgroundImage: AssetImage(logo),
                  backgroundColor: deepGreen,
                  
                ),
                SizedBox(height: 30.h,),
           

              drowText(context, translatedData(context, "welcome"), 27, color: white),
              
          

                SizedBox(height: 170.h,),
               
  
              drowContiner(50, 200, 0, 0, deepGreen, Row(children: [
                langButtom(context,icon: langIcon),
                 SizedBox(width: 10.w,),
                drowText(context,  translatedData(context, "choose the language"), 14),
                
              ],))
              
              ],
              ),
            ),
          ),
        ));
  }
}
