import 'package:aoun/home/AdmainHom/AddChair.dart';
import 'package:aoun/home/AdmainHom/dontalRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widget/Colors.dart';
import '../../Widget/widget.dart';
import 'chairRequests.dart';

class ManageWheelChair extends StatefulWidget {
  ManageWheelChair({Key key}) : super(key: key);

  @override
  State<ManageWheelChair> createState() => _ManageWheelChairState();
}

class _ManageWheelChairState extends State<ManageWheelChair> {
  int select = 1;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
          title: drowText(context, "إدارة الكراسي المتحركة", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          //color: green,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: drowButtoms(context, 'طلبات التبرع',
                              select == 1 ? 14 : 12, white, () {
                            setState(() {
                              select = 1;
                            });
                          }, backgrounColor: deepGreen),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: drowButtoms(context, 'طلبات الكراسي',
                              select == 2 ? 14 : 12, white, () {
                            setState(() {
                              select = 2;
                            });
                          }, backgrounColor: deepGreen),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: drowButtoms(context, 'اضافة كرسي',
                              select == 3 ? 14 : 12, white, () {
                            setState(() {
                              select = 3;
                            });
                          }, backgrounColor: deepGreen),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.h),
                    child: drowText(
                        context,
                        select == 1
                            ? "طلبات التبرع"
                            : select == 2
                                ? "طلبات الكرسي"
                                : "اضافة كرسي",
                        15,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  //SizedBox(height: 10.h),
//dontal request---------------------------------------------------------------------
                  select == 1
                      ? Expanded(flex: 4, child: dontalRequest())

//chiar request------------------------------------------------------------------------------------
                      : select == 2
                          ? Expanded(flex: 4, child: chairRequests())
                          :
//---------------------------------------------------------
                          Expanded(child: addChair())
                ],
              ))),
    );
  }

  //show products-------------------------------

}
