import 'dart:math';
import 'dart:developer' as l;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';
import '../../core/bloc/cubit/app_cubit.dart';
import '../../core/router/router.dart';
import 'add_weight_bottom_sheet.dart';
import 'main_text.dart';

class WeightItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  const WeightItem({required this.data, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Image.asset(
            getAsset('weight'),
            height: 35.h,
            width: 35.w,
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: '${data['user_weight']} KG',
                  font: 18.sp,
                  weight: FontWeight.bold,
                ),
                MainText(
                  text: DateFormat('dd MMM yyyy')
                      .format(DateTime.parse(data['date_time'])),
                  font: 14.sp,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: navigatorKey.currentContext!,
                      builder: (_) => AddWeighBottomSheet(isUpdate: true,data: data,),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            topLeft: Radius.circular(20.r),
                          )));
                },
                child: Container(
                  width: 30.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: Icon(
                    Icons.edit,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  cubit.deleteWeight(data.id);
                },
                child: Container(
                  width: 30.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Icon(
                    Icons.delete,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
