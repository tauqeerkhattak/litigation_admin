import 'dart:developer';

import 'package:control_room/control_room.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/constants.dart';

abstract class BaseController<S> extends StateController<S> {
  final S initialState;

  BaseController(this.initialState) : super(initialState);

  Future<T?> safeAction<T>(AsyncValueGetter<T> callback) async {
    try {
      return await callback();
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      handleError(e.toString());
      return null;
    }
  }

  @mustCallSuper
  void handleError(String message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message.replaceAll('Exception: ', '')),
        backgroundColor: AppColors.red,
      ),
    );
  }
}
