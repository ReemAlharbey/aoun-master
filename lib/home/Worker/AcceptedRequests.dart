import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../TransilatClass/getTranselaitData.dart';
import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/image.dart';
import '../../Widget/widget.dart';

class AcceptedRequests extends StatefulWidget {
  AcceptedRequests({Key key}) : super(key: key);

  @override
  State<AcceptedRequests> createState() => _AcceptedRequestsState();
}

class _AcceptedRequestsState extends State<AcceptedRequests> {
  List userRecord = [];
  String stateValue='';
  List<String>stutsCode=[
    "قيد التجهيز",
    "في الطريق",
    "تم التسليم",
  ];
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: drowText(context, "الطلبات المقبولة", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage(
          //       welcomImage,
          //     ),
          //     fit: BoxFit.cover,
          //     colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        child: StreamBuilder(
            stream: userCollection.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshat) {
              if (snapshat.hasError) {
                awesomDialog(context, "الاشعارات",
                    "خطا في استرجاع البيانات من قاعدة البيانات");
              }
              if (snapshat.hasData) {
                return getUsers(context, snapshat);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  //show products-------------------------------
  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 14.h),
      child: ListView.builder(
          //shrinkWrap: true,
          itemCount: snapshat.data.docs.length,
          itemBuilder: (context, i) {
            print(
              snapshat.data.docs.length,
            );
            return SizedBox(
              height: 150.h,
              child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Card(
                      elevation: 5,
                      color: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        // side: BorderSide(color: deepGreen, width: 2)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(12.0.h),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: getData("رقم الطلب : ", "111111111")),
                            Expanded(child: getData("رقم الاستلام : ", "111111111")),
                            Expanded(
                              child: drowMenu("حالة الطلب", stuts, stutsCode, (value) {
                                setState(() {
                                  stateValue = value;
                                });
                                print(stateValue);
                              }, (value) {
                                if (value == null) {
                                  return translatedData(
                                      context, "Fill in the field");
                                } else {
                                  return null;
                                }
                              },width:150.w),
                            ),
                          ],
                        ),
                      ))),
            );
          }),
    );
  }

  Widget getData(String title, String title2) {
    return Row(
     
      children: [
      Expanded(child: drowText(context, title, 13, fontWeight: FontWeight.w400, color: black)),
      SizedBox(width: 10.w),
      Expanded(child: drowText(context, title2, 13, fontWeight: FontWeight.w400, color: black))
    ]);
  }
}
