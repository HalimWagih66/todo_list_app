import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/base%20view/base_view.dart';
import 'package:todo_list_app/screens/register%20screen/register_connector.dart';
import 'package:todo_list_app/screens/register%20screen/register_viewmodel.dart';
import 'package:todo_list_app/screens/register%20screen/validation%20Email.dart';
import '../../provider/application_provider.dart';
import '../../shared/component/TextFormField/custom_form_field.dart';
import '../../shared/style/color application/colors_application.dart';


class RegisterScreen extends StatefulWidget{
  static String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseView<RegisterViewModel,RegisterScreen> implements RegisterConnector {
  bool isHidePassword = true;

  IconData eyePassword = Icons.remove_red_eye;

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmationController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector=this;
  }
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
              color: ColorApp.getColorApplication(context),
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/register screen/register_background.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.create_account),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.25,
                      ),
                      CustomFormField(
                        textLabel: AppLocalizations.of(context)!.full_name,
                        inputField: fullNameController,
                        functionValidate: (text) {
                          if (text?.isEmpty == true || text
                              ?.trim()
                              .isEmpty == true) {
                            return AppLocalizations.of(context)!.please_enter_your_name;
                          }
                          if (text?.contains(" ") == false) {
                            return AppLocalizations.of(context)!.please_enter_at_least_the_binary_name;
                          }
                        },
                        BorderField: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 2)
                        ),
                        prefix_Icon: Icons.person,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        textLabel: AppLocalizations.of(context)!.email_address,
                        inputField: emailController,
                        functionValidate: (text) {
                          if (text?.isEmpty == true || text
                              ?.trim()
                              .isEmpty == true) {
                            return AppLocalizations.of(context)!.please_enter_email_address;
                          }
                          if (!ValidationEmail.isEmail(text!)) {
                            return AppLocalizations.of(context)!.please_enter_the_email_correctly;
                          }
                        },
                        BorderField: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 2)
                        ),
                        prefix_Icon: Icons.email,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        textLabel: AppLocalizations.of(context)!.password,
                        inputField: passwordController,
                        functionValidate: (text) {
                          if (text == null || text?.isEmpty == true || text
                              ?.trim()
                              .isEmpty == true) {
                            return AppLocalizations.of(context)!.please_enter_password;
                          }
                          if (text!.length < 6) {
                            return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
                          }
                        },
                        BorderField: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 1)
                        ),
                        onPressedsuffix_Icon: () {
                          isHidePassword = !isHidePassword;
                          eyePassword =
                          isHidePassword == true ? Icons.remove_red_eye : Icons
                              .remove_red_eye_outlined;
                          setState(() {});
                        },
                        prefix_Icon: Icons.password,
                        suffix_Icon: eyePassword,
                        obscure_Text: isHidePassword,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        textLabel: AppLocalizations.of(context)!.confirm_password,
                        inputField: passwordConfirmationController,
                        functionValidate: (text) {
                          if (text == null || text?.isEmpty == true || text
                              ?.trim()
                              .isEmpty == true) {
                            return AppLocalizations.of(context)!.please_enter_Confirm_password;
                          }
                          if (text != passwordController.text) {
                            return AppLocalizations.of(context)!.this_password_does_not_match_the_main_password;
                          }
                        },
                        BorderField: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 1)
                        ),
                        onPressedsuffix_Icon: () {
                          isHidePassword = !isHidePassword;
                          eyePassword =
                          isHidePassword == true ? Icons.remove_red_eye : Icons
                              .remove_red_eye_outlined;
                          setState(() {});
                        },
                        prefix_Icon: Icons.password,
                        suffix_Icon: eyePassword,
                        obscure_Text: isHidePassword,
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * .07,),
                      ElevatedButton(onPressed: () {
                        if(formKey.currentState?.validate() == false)return;
                        viewModel.createAccount(emailController.text, passwordController.text, fullNameController.text, context);
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.create_account,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorApp.isDarkEnabled(context)?Colors.black:Colors.grey)),
                          Icon(Icons.arrow_forward_outlined, color: ColorApp.isDarkEnabled(context)?Colors.black:Colors.grey),
                        ],
                      ),

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 33),
                          backgroundColor: ColorApp.isDarkEnabled(context) ? Theme.of(context).primaryColor:Color(0xffDFECDB),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      TextButton(onPressed: () {
                        // navigatorReplaceReplacement login
                      }, child: Text(AppLocalizations.of(context)!.i_already_have_an_account)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // @override
  // void goToLogin() {
  //   Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  // }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }


}
