import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/base%20view/base_view.dart';
import 'package:todo_list_app/screens/login%20screen/login_connnector.dart';
import '../../database/my_database.dart';
import '../../provider/application_provider.dart';
import '../../provider/auth_provider.dart';
import '../../shared/component/TextFormField/custom_form_field.dart';
import '../../shared/style/color application/colors_application.dart';
import '../register screen/register_screen.dart';
import '../register screen/validation Email.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel,LoginScreen> implements LoginConnector{
  bool isHidePassword = true;

  IconData eyePassword = Icons.remove_red_eye;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector=this;
  }
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder:(context, child) => Container(
        decoration: BoxDecoration(
            color: ColorApp.getColorApplication(context),
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/register screen/register_background.png"),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.login),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                    ),
                    Text(AppLocalizations.of(context)!.welcome_back,
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    CustomFormField(
                      textLabel: AppLocalizations.of(context)!.email_address,
                      inputField: emailController,
                      functionValidate: (text) {
                        if (text?.isEmpty == true ||
                            text?.trim().isEmpty == true) {
                          return AppLocalizations.of(context)!.please_enter_email_address;
                        }
                        if (!ValidationEmail.isEmail(text!)) {
                          return AppLocalizations.of(context)!.please_enter_the_email_correctly;
                        }
                      },
                      BorderField: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 2)),
                      prefix_Icon: Icons.email,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomFormField(
                      textLabel: AppLocalizations.of(context)!.password,
                      inputField: passwordController,
                      functionValidate: (text) {
                        if (text == null ||
                            text?.isEmpty == true ||
                            text?.trim().isEmpty == true) {
                          return AppLocalizations.of(context)!.please_enter_password;
                        }
                        if (text!.length < 6) {
                          return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
                        }
                      },
                      BorderField: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1)),
                      onPressedsuffix_Icon: () {
                        isHidePassword = !isHidePassword;
                        eyePassword = isHidePassword == true
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined;
                        setState(() {});
                      },
                      prefix_Icon: Icons.password,
                      suffix_Icon: eyePassword,
                      obscure_Text: isHidePassword,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == false) return;
                        viewModel.login(password: passwordController.text,email: emailController.text,name: emailController.text,context: context);
                      },
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.login,
                                style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorApp.isDarkEnabled(context)?Colors.black:Colors.grey)),
                            Icon(Icons.arrow_forward_outlined,
                                color: ColorApp.isDarkEnabled(context)?Colors.black:Colors.grey),
                          ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 33),
                        backgroundColor: ColorApp.isDarkEnabled(context) ? Theme.of(context).primaryColor:Color(0xffDFECDB),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          goToRegister();
                        },
                        child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.i_don_t_have_an_account,
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome() {
    // TODO: implement goToHome
  }

  @override
  void goToRegister() {
    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
  }


}
