import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/base%20connector/base_connector.dart';
class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier{
  CON? connector;
}