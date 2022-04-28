// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/widget.dart';

class chairRequests extends StatefulWidget {
  chairRequests({Key key}) : super(key: key);

  @override
  State<chairRequests> createState() => _chairRequestsState();
}

class _chairRequestsState extends State<chairRequests> {
  CollectionReference userRequests =
      FirebaseFirestore.instance.collection("userRequests");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: userRequests.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshat) {
            if (snapshat.hasError) {
              awesomDialog(context, "ادارة الكراسي",
                  "خطا في استرجاع البيانات من قاعدة البيانات");
            }
            if (snapshat.hasData) {
              return getUserRequests(context, snapshat);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget getUserRequests(BuildContext context, AsyncSnapshot snapshat) {
    if (snapshat.data.docs.length > 0) {
      return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 14.h),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                //shrinkWrap: true,
                itemCount: snapshat.data.docs.length,
                itemBuilder: (context, i) {
                  print(
                    snapshat.data.docs.length,
                  );
//delete----------------------------------------------------------
                  return SizedBox(
                    height: 160.h,
                    child: Card(
                      elevation: 5,
                      color: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: deepGreen, width: 1)),
                      child: Column(
                        children: [
                          getData(
                              snapshat.data.docs[i].data()['name'],
                              nameIcon,
                              snapshat.data.docs[i].data()['phone'],
                              phoneIcon),
                          SizedBox(height: 5.w),
                          getData(
                              snapshat.data.docs[i].data()['userChairNumber'],
                              chairNumber,
                              snapshat.data.docs[i].data()['userRequestType'],
                              requestType),
                          SizedBox(height: 5.w),
                          getData(
                              snapshat.data.docs[i].data()['formatStarTime'],
                              starTime,
                              snapshat.data.docs[i].data()['formatEndTime'],
                              endTime),
                          SizedBox(height: 5.w),
                          Padding(
                            padding: EdgeInsets.all(8.0.h),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
    } else {
      return Center(
            child: drowText(context, "لاتوجد طلبات حاليا", 15, color: black));
    }
  }

//get data from database--------------------------------------
  Widget getData(text1, icon1, text2, icon2) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Row(children: [
              Icon(
                icon1,
                color: deepGreen,
              ),
              SizedBox(width: 10.w),
              drowText(context, '$text1', 13,
                  fontWeight: FontWeight.w400, color: black)
            ]),
          ),
          //-----------------------

          Expanded(
            child: Row(children: [
              Icon(
                icon2,
                color: deepGreen,
              ),
              SizedBox(width: 10.w),
              drowText(context, '$text2', 13,
                  fontWeight: FontWeight.w400, color: black)
            ]),
          ),
        ]),
      ),
    );
  }
}
