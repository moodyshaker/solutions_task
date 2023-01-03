import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solutions_task/constants.dart';
import 'package:solutions_task/core/bloc/cubit/app_cubit.dart';
import 'package:solutions_task/feature/widgets/customScaffold.dart';
import 'package:solutions_task/feature/widgets/weight_item.dart';
import '../widgets/main_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return CustomScaffold(
        isHome: true,
        title: 'Home',
        body: StreamBuilder(
          stream: cubit.firestore
              .collection(cubit.auth.currentUser!.uid)
              .orderBy('date_time')
              .snapshots(),
          builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: SpinKitFadingCircle(
                        color: kPrimaryColor,
                      ),
                    )
                  : snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int i) =>
                              WeightItem(data: snapshot.data!.docs[i]))
                      : Center(
                          child: MainText(
                            text: 'No Data',
                          ),
                        ),
        ));
  }
}
