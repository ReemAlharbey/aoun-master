import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/widget.dart';

class dontalRequest extends StatefulWidget {
  dontalRequest({Key key}) : super(key: key);

  @override
  State<dontalRequest> createState() => _dontalRequestState();
}

class _dontalRequestState extends State<dontalRequest> {
  CollectionReference userRequests =
      FirebaseFirestore.instance.collection("donateWheelchairRequest");
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: StreamBuilder(
            stream: userRequests.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshat) {
              if (snapshat.hasError) {
                awesomDialog(context, "ادارة الكراسي",
                    "خطا في استرجاع البيانات من قاعدة البيانات");
              }
              if (snapshat.hasData) {
                return  snapshat.data.docs.length > 0
                              ?ListView.builder(
                    //shrinkWrap: true,
                    itemCount: snapshat.data.docs.length,
                    itemBuilder: (context, i) {
                      print(
                        snapshat.data.docs.length,
                      );
                      //delete----------------------------------------------------------
                      return SizedBox(
                        height: 120.h,
                        child: Card(
                          elevation: 5,
                          color: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: deepGreen, width: 2)),
                          child: Column(
                            children: [
                              SizedBox(height: 10.w),
                              getData(context, "${snapshat.data.docs[i].data()['name']}", nameIcon),
                              SizedBox(height: 5.w),
                              getData(context,"${snapshat.data.docs[i].data()['identity']}", iDIcon),
                              SizedBox(height: 5.w),
                              getData(context, "${snapshat.data.docs[i].data()['chairNumber']}", chairNumber),
                              SizedBox(height: 5.w),
                            ],
                          ),
                        ),
                      );
                    }):Center(
            child: drowText(context, "لاتوجد طلبات حاليا", 15, color: black));
   
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
