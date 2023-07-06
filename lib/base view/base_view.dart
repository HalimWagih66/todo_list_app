import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/base%20connector/base_connector.dart';
import 'package:todo_list_app/base%20viewmodel/base_viewmode.dart';
import '../provider/application_provider.dart';
import '../shared/style/color application/colors_application.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseView<VM extends BaseViewModel,T extends StatefulWidget> extends State<T> implements BaseConnector{

  late VM viewModel;
  VM initViewModel();
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void showLoading() {
    var appProvider = Provider.of<ApplicationProvider>(context,listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            backgroundColor:
            ColorApp.isDarkEnabled(context)?Color(0xff141922):Colors.white,
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 14),
                Text(AppLocalizations.of(context)!.loading,style: TextStyle(color: ColorApp.isDarkEnabled(context)==true?Colors.white:Colors.black)),
              ],
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showMessage({
    required String message,
    required DialogType dialogType,
    String? title,
    String? posActionName,
    Function? posAction,
    String? nigActionName,
    Function? nigAction,
  }) {
    var appProvider = Provider.of<ApplicationProvider>(context, listen: false);
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dialogBackgroundColor:
      ColorApp.isDarkEnabled(context) ? Color(0xff141922) : Colors.white,
      context: context,
      dialogType: dialogType,
      title: title,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      animType: AnimType.rightSlide,
      desc: message,
      btnCancelOnPress: nigActionName != null
          ? () {
        nigAction?.call();
      }
          : null,
      btnOkOnPress: posActionName != null
          ? () {
        posAction?.call();
      }
          : null,
      btnOkText: posActionName,
      btnCancelText: nigActionName,
    )..show();
  }

}