// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/image.dart';
import '../../Widget/widget.dart';

class WorkerRequest extends StatefulWidget {
  WorkerRequest({Key key}) : super(key: key);

  @override
  State<WorkerRequest> createState() => _WorkerRequestState();
}

class _WorkerRequestState extends State<WorkerRequest> {
  CollectionReference userRequests =
      FirebaseFirestore.instance.collection("userRequests");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: drowText(context, "إدارة طلبات الكراسي المتحركة", 15),
            centerTitle: true,
            backgroundColor: deepGreen),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
                // image: AssetImage(
                //   welcomImage,
                // ),
                // fit: BoxFit.cover,
                // colorFilter:
                //     ColorFilter.mode(Colors.black54, BlendMode.darken)
     // ),
         // ),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                  child:
                      drowText(context, "الطلبات الحالية", 20, color: black)),
              Expanded(
                flex: 3,

                //color: green,
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
              ),
            ],
          ),
        ));
  }

  //show products-------------------------------
  Widget getUserRequests(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 14.h),
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
                    height: 200.h,
                    child: Card(
                      elevation: 5,
                      color: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: deepGreen, width: 1)
                      ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buttom("", Icons.check_circle_outline, () {}),
                                buttom("", Icons.unpublished, () {}),
                                buttom("", Icons.location_on, () async {
                                  var url =
                                      "https://www.google.com/maps/search/?api=1&query=${snapshat.data.docs[i].data()['latitude']},${snapshat.data.docs[i].data()['longtitude']}";
                                  try {
                                    if (await canLaunch(url.toString())) {
                                      awesomDialog(context, 'Create an account',
                                          'wating');
                                      launch(url.toString());
                                      Navigator.pop(context);
                                    } else {
                                      awesomDialog(
                                          context, '', 'الرابط غير صالح');
                                    }
                                  } catch (e) {
                                    awesomDialog(context, '', e.toString());
                                  }
                                }),
                                buttom("", Icons.chat, () {})
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child: drowText(context, "لاتوجد طلبات حاليا", 15, color: black));
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

  Widget buttom(String name, IconData, onPressed) {
    return SizedBox(
      width: 70.w,
      child: RaisedButton.icon(
        elevation: 10,
        padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
          
              borderRadius: BorderRadius.circular(100.r)),
          color: deepGreen,
          onPressed: onPressed,
          icon: Icon(IconData, color: white),
          label: Text('')),
    );
  }
}
