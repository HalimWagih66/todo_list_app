import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

abstract class BaseConnector{

  void showMessage(
      {
        required String message,
        required DialogType dialogType,
        String? title,
        String? posActionName,
        Function? posAction,
        String? nigActionName,
        Function? nigAction});

  void showLoading();

  void hideDialog();

}