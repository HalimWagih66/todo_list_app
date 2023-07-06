import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/base%20viewmodel/base_viewmode.dart';
import 'package:todo_list_app/database/models/user.dart' as MyUser;
import 'package:todo_list_app/screens/register%20screen/register_connector.dart';
import '../../database/my_database.dart';
import '../../provider/application_provider.dart';
import '../../provider/auth_provider.dart';
import '../../shared/component/dialog/dialog utils.dart';

class RegisterViewModel extends BaseViewModel<RegisterConnector>{

  void createAccount(String email,String password,String name,BuildContext context) async {
    try {
      connector?.showLoading();
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser.User user = MyUser.User(id: result.user?.uid ?? "",email: email,name: name);
      MyDataBase.addUser(result.user?.uid ?? "", user);
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      authProvider.updateUser(user);
      var appProvider = Provider.of<ApplicationProvider>(context,listen: false);
      connector?.hideDialog();
      connector?.showMessage(message:  AppLocalizations.of(context)!.your_account_has_been_successfully_registered,
          dialogType: DialogType.success, posActionName: AppLocalizations.of(context)!.ok,
          posAction: () {
        //Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }
      );
      print("register");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector?.showMessage(title: AppLocalizations.of(context)!.weak_password,message: AppLocalizations.of(context)!.the_password_provided_is_too_weak,dialogType: DialogType.error,posAction: DialogUtils.hideDialog(context),posActionName:AppLocalizations.of(context)?.ok);
      } else if (e.code == 'email-already-in-use') {
        connector?.showMessage(title: AppLocalizations.of(context)!.email_address,message: AppLocalizations.of(context)!.the_account_already_exists_for_that_email,dialogType: DialogType.error,posActionName: AppLocalizations.of(context)?.ok,posAction: DialogUtils.hideDialog(context));
      }
    } catch (e) {
      connector?.showMessage(title: AppLocalizations.of(context)!.something_went_error,message: e.toString(),dialogType: DialogType.error,posActionName: AppLocalizations.of(context)?.ok,posAction: DialogUtils.hideDialog(context));
    }
  }
}