import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/base%20viewmodel/base_viewmode.dart';
import 'package:todo_list_app/screens/login%20screen/login_connnector.dart';
import '../../database/my_database.dart';
import '../../provider/application_provider.dart';
import '../../provider/auth_provider.dart';
import 'package:todo_list_app/database/models/user.dart' as MyUser;

class LoginViewModel extends BaseViewModel<LoginConnector>{
  void login(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      connector?.showLoading();
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      MyUser.User? user = await MyDataBase.readUser(result.user?.uid ?? "");
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      if(user == null){
        connector?.showMessage(title: AppLocalizations.of(context)!.error, message: AppLocalizations.of(context)!.dear_this_account_is_not_registered_before_please_read_the_data_again, dialogType: DialogType.error,posActionName: "Ok");
        return;
      }
      authProvider.updateUser(user);
      //var appProvider = Provider.of<ApplicationProvider>(context,listen: false);
      //appProvider.changeLoginInUser(false);
      connector?.hideDialog();
      connector?.showMessage(
          title: AppLocalizations.of(context)!.registration_successful,
          message: AppLocalizations.of(context)!.do_you_want_to_go_to_the_home_screen,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: () {
            //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          dialogType: DialogType.success);
    } on FirebaseAuthException catch (e) {
      connector?.hideDialog();
      if (e.code == 'user-not-found') {
        connector?.showMessage(
            title: AppLocalizations.of(context)!.user_not_found,
            message: AppLocalizations.of(context)!.no_user_found_for_that_email,
            dialogType: DialogType.error,
            nigActionName: AppLocalizations.of(context)!.cancel);
      } else if (e.code == 'wrong-password') {
        connector?.showMessage(
            title: AppLocalizations.of(context)!.wrong_password,
            message: AppLocalizations.of(context)!.wrong_password_provided_for_that_user,
            dialogType: DialogType.error,
            nigActionName: AppLocalizations.of(context)!.cancel);
      }
    }
  }
}