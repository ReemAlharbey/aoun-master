import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


awesomDialog(context, String title, String content,
    {bool showButtom = false, yesFunction, noFunction}) {
  return showDialog(
    //barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: content == "wating" ? Colors.transparent : white,

//titel-------------------------------------------------------------------

          title: content != "wating"
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: drowText(
                    context,
                    translatedData(context, title),
                    15,
                  color: deepGreen,
                  fontWeight: FontWeight.bold
                  ),
                ),
              )
              : SizedBox(),
//contint area-------------------------------------------------------------------

          content: content != "wating"
              ? SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
//contint titel-------------------------------------------------------------------
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: drowText(
                            context,
                           translatedData(context, content) ,
                            13,
                            color:black,
                          ),
                        ),
                      ),

//divider-------------------------------------------------------------------

                      showButtom
                          ? Divider(
                              thickness: 2,
                              color: Colors.grey[500],
                            )
                          : SizedBox(),
                      SizedBox(height: 10.h),
//buttoms-------------------------------------------------------------------

                      showButtom
                          ? Expanded(
                              flex: 1,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
// yes buttoms-------------------------------------------------------------------

                                    Expanded(
                                        child: drowButtoms(
                                         
                                      context,
                                      "??????",
                                      16.0,
                                      white,
                                      () {
                                        yesFunction();
                                      },
                                        backgrounColor:deepGreen,
                                      evaluation: 0,
                                     
                                    )
                                    ),

                                    SizedBox(width: 20.w),
//no buttom-------------------------------------------------------------------

                                    Expanded(
                                        child: drowButtoms(
                                      context,
                                      "????",
                                      16.0,
                                      white,
                                      () {
                                        noFunction();
                                      },
                                       backgrounColor:deepGreen,
                                      evaluation: 0,
                                    ))
                                  ]),
                            )
                          : SizedBox(),
                    ],
                  ))
//Show Waiting image-------------------------------------------------------
              : SizedBox(
                  width: double.infinity,
                  height: 150.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child:CircularProgressIndicator()
                  ),
                ),

//Show buttoms -------------------------------------------------------

          actions: [
            showButtom == false && content != "wating"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear, color: deepGreen)),
                  )
                : SizedBox()
          ],
        );
      });
}