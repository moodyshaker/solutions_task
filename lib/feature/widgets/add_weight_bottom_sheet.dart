import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solutions_task/core/router/router.dart';

import '../../core/bloc/cubit/app_cubit.dart';
import 'customButton.dart';
import 'customTextFeild.dart';

class AddWeighBottomSheet extends StatefulWidget {
  final bool isUpdate;
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;

  const AddWeighBottomSheet({this.isUpdate = false, this.data, Key? key})
      : super(key: key);

  @override
  State<AddWeighBottomSheet> createState() => _AddWeighBottomSheetState();
}

class _AddWeighBottomSheetState extends State<AddWeighBottomSheet> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).weightController.clear();
    if (widget.isUpdate) {
      AppCubit.get(context).weightController.text = widget.data!['user_weight'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: cubit.weightController,
              hint: 'your weight',
              type: TextInputType.number,
              valid: (String? v) =>
                  (v != null && v.isNotEmpty) ? null : 'enter your weight',
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                title: 'Add',
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    if (widget.isUpdate) {
                      await cubit.updateWeight(widget.data!.id);
                    } else {
                      await cubit.addNewWeight();
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
