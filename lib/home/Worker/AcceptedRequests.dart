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
  String stateValue = '';
  List<String> stutsCode = [
    "قيد التجهيز",
    "في الطريق",
    "تم التسليم",
  ];
  CollectionReference acceptRequestCollection =
      FirebaseFirestore.instance.collection("acceptRequest");
  CollectionReference userRequestsCollection =
      FirebaseFirestore.instance.collection("userRequests");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
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
            stream: acceptRequestCollection.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshat) {
              if (snapshat.hasError) {
                awesomDialog(
                    context, "", "خطا في استرجاع البيانات من قاعدة البيانات");
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
    return snapshat.data.docs.length > 0
        ? Padding(
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
                              padding: EdgeInsets.all(12.0.h),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: getData("رقم الطلب : ",
                                          '${snapshat.data.docs[i].data()['requestNumber']}')),
                                  Expanded(
                                      child: getData("وقت التسليم : ",
                                          '${snapshat.data.docs[i].data()['formatEndTime']}')),
                                  Expanded(
                                    child: snapshat.data.docs[i]
                                                .data()['state'] !=
                                            'تم التسليم'
                                        ? drowMenu(
                                            '${snapshat.data.docs[i].data()['state']}',
                                            chairNumber,
                                            stutsCode, (value) {
                                            setState(() {
                                              stateValue = value;
                                              awesomDialog(
                                                  context,
                                                  'Create an account',
                                                  'wating');
                                            
                                              acceptRequestCollection
                                                  .doc(
                                                      "${snapshat.data.docs[i].id}")
                                                  .update({
                                                'state': stateValue,
                                              }).then((value) {
                                                Navigator.pop(context);
                                                FirebaseFirestore.instance
                                                    .collection("messege")
                                                    .add({
                                                  'masseg': ' طلبك $stateValue',
                                                  'date':
                                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                  'time':
                                                      "${DateTime.now().hour} : ${DateTime.now().minute}",
                                                  'userId': snapshat
                                                      .data.docs[i]
                                                      .data()['userId'],
                                                  'createOn': DateTime.now(),
                                                });
                                              });
                                            });
                                            print(stateValue);
                                          }, (value) {
                                            if (value == null) {
                                              return translatedData(
                                                  context, "Fill in the field");
                                            } else {
                                              return null;
                                            }
                                          }, width: 150.w)
                                        : drowText(
                                            context,
                                            "تم تسليم الطلب",
                                            14,
                                            color: green,
                                          ),
                                  ),
                                ],
                              ),
                            ))),
                  );
                }),
          )
        : Center(
            child: drowText(context, "لاتوجد طلبات حاليا", 15, color: black));
  }

  Widget getData(String title, String title2) {
    return Row(children: [
      Expanded(
          child: drowText(context, title, 13,
              fontWeight: FontWeight.w400, color: black)),
      SizedBox(width: 10.w),
      Expanded(
          child: drowText(context, title2, 13,
              fontWeight: FontWeight.w400, color: black))
    ]);
  }
}
