import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solutions_task/core/bloc/app_state.dart';
import 'package:solutions_task/core/router/router.dart';
import 'package:solutions_task/feature/screen/login_anonymous.dart';

import 'core/bloc/cubit/app_cubit.dart';
import 'feature/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext ctx, Widget? child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Solution Task',
          navigatorKey: navigatorKey,
          home: BlocConsumer<AppCubit, AppState>(
            listener: (BuildContext context, AppState state) {},
            builder: (BuildContext context, AppState state) {
              final cubit = AppCubit.get(context);
              return StreamBuilder(
                  stream: cubit.userState,
                  builder: (ctx, snapshot) =>
                      snapshot.data != null ? Home() : LoginAnonymous());
            },
          ),
        ),
      ),
    );
  }
}
