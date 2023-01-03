import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solutions_task/constants.dart';
import 'package:solutions_task/core/bloc/cubit/app_cubit.dart';
import 'package:solutions_task/feature/widgets/customButton.dart';
import 'package:solutions_task/feature/widgets/customScaffold.dart';

import '../../core/bloc/app_state.dart';

class LoginAnonymous extends StatelessWidget {
  const LoginAnonymous({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return CustomScaffold(
      title: 'Login',
      body: Center(
        child: BlocConsumer<AppCubit, AppState>(
            listener: (BuildContext context, AppState state) {},
            builder: (BuildContext context, AppState state) =>
                state is LoadingState
                    ? SpinKitFadingCircle(color: kPrimaryColor,)
                    : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            title: 'Login Anonymous',
                            onPressed: () async => cubit.loginAnonymous(),
                          ),
                        ],
                      ),
                    ],
                      )),
      ),
    );
  }
}
