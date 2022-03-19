import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class donateWheelchar extends StatefulWidget {
  donateWheelchar({Key key}) : super(key: key);

  @override
  State<donateWheelchar> createState() => _donateWheelcharState();
}

class _donateWheelcharState extends State<donateWheelchar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          drowText(context, "التبرع بكرسي متحرك", 18, color: deepGreen),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               drowTextField(context, chairNumber, "عدد الكراسي", false, passController, (val){}),
                SizedBox(height: 10.h),
                drowButtoms(context, "رفع الطلب", 12, white, () {},
                    backgrounColor: deepGreen),
               SizedBox(
              height: 40.h,
          ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
