import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutions_task/core/router/router.dart';
import 'package:solutions_task/feature/widgets/action_dialog.dart';
import '../app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> userState = FirebaseAuth.instance.authStateChanges();
  
  TextEditingController weightController = TextEditingController();

  Future<void> loginAnonymous() async {
    emit(LoadingState());
    try {
      await auth.signInAnonymously();
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => ActionDialog(
                content: e.message,
                approveAction: 'Okay',
                onApproveClick: () {
                  MagicRouter.pop();
                },
              ));
      emit(ErrorState());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => ActionDialog(
                content: e.message,
                approveAction: 'Okay',
                onApproveClick: () {
                  MagicRouter.pop();
                },
              ));
    }
  }

  Future<void> deleteWeight(String id) async {
    await firestore.collection(auth.currentUser!.uid).doc('$id').delete();
  }

  Future<void> updateWeight(
    String id,
  ) async {
    await firestore.collection(auth.currentUser!.uid).doc(id).update({
      'user_weight': weightController.text,
      'date_time': DateTime.now().toIso8601String(),
    });
    weightController.clear();
    MagicRouter.pop();
  }

  Future<void> addNewWeight() async {
    firestore.collection(auth.currentUser!.uid).add({
      'user_weight': weightController.text,
      'date_time': DateTime.now().toIso8601String(),
    });
    MagicRouter.pop();
  }
}
