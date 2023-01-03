import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solutions_task/feature/widgets/add_weight_bottom_sheet.dart';
import '../../constants.dart';
import '../../core/bloc/cubit/app_cubit.dart';
import '../../core/router/router.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class CustomScaffold extends StatefulWidget {
  final String? title;
  final bool isHome;
  final bool isNotification;
  final Widget body;
  final Function()? onBackPressed;

  const CustomScaffold(
      {this.title,
      required this.body,
      this.isHome = false,
      this.isNotification = false,
      this.onBackPressed,
      Key? key})
      : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        if (!MagicRouter.canPop) {
          showDialog(
              context: navigatorKey.currentContext!,
              builder: (c) => ActionDialog(
                    content: 'Do you want to exit ?',
                    onCancelClick: () {
                      MagicRouter.pop();
                    },
                    approveAction: 'Yes',
                    cancelAction: 'No',
                    onApproveClick: () {
                      MagicRouter.pop();
                      SystemNavigator.pop();
                    },
                  ));
        } else {
          widget.onBackPressed != null
              ? widget.onBackPressed!()
              : MagicRouter.pop();
        }
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: navigatorKey.currentContext!,
                builder: (_) => AddWeighBottomSheet(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                )));
          },
          child: Icon(Icons.add),
          backgroundColor: kMainColor,
        ),
        appBar: AppBar(
          actions: [
            widget.isHome
                ? IconButton(
                    onPressed: () async => await cubit.logout(),
                    icon: Icon(
                      Icons.login_sharp,
                      color: kWhiteBlueColor,
                    ))
                : Container()
          ],
          backgroundColor: kMainColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: MainText(
            text: widget.title!.toUpperCase(),
            color: kAccentColor,
          ),
        ),
        body: widget.body,
      ),
    );
  }
}
