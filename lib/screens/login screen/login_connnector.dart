import 'package:todo_list_app/base%20connector/base_connector.dart';

abstract class LoginConnector extends BaseConnector{
  void goToRegister();
  void goToHome();
}