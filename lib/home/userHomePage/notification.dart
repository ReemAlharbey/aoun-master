import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/widget.dart';

// ignore: camel_case_types
class notification extends StatefulWidget {
  notification({Key key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

// ignore: camel_case_types
class _notificationState extends State<notification> {
  String userId = '';
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
  }

  List userRecord = [];
  CollectionReference messegeCollection =
      FirebaseFirestore.instance.collection("messege");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: drawer(context),
      appBar: AppBar(
          title: drowText(context, "الاشعارات", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        //color: green,
        child: StreamBuilder(
            stream: messegeCollection
                .where("userId", isEqualTo: userId).orderBy('createOn', descending: true)
                .snapshots(),
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
//delete----------------------------------------------------------
                  return SizedBox(
                    height: 100.h,
                    child: Card(
                      elevation: 5,
                      color: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: deepGreen, width: 2)),
                      child: Column(
                        children: [
                          getData(
                             '${snapshat.data.docs[i].data()['masseg']}','${snapshat.data.docs[i].data()['date']} -'+' ${snapshat.data.docs[i].data()['time']}'),
                          SizedBox(height: 5.w),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child: drowText(context, "لاتوجد اشعارات حاليا", 15, color: black));
  }

//get data from database--------------------------------------
  Widget getData(text,String subtitle) {
    return Expanded(
      child: ListTile(
        title: drowText(context, text, 12, color: black),
        leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: deepGreen,
          child: Center(child: Icon(notificationsIcon)),
        ),
        subtitle: drowText(context, subtitle, 12,color: deepGreen)
      ),
    );
  }
}
