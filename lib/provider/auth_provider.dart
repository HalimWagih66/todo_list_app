import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/network/local/shared_preferences/shared_prefs.dart';
import '../database/models/user.dart';

class AuthProvider extends ChangeNotifier{
  User? currentUser;
  AuthProvider(){
   List<String>?dateUser = SharedPrefs.getUserFromSharedPreferences();
   if(dateUser?[0] != null || dateUser?[0].isEmpty != true){
     currentUser = User(id: dateUser?[0], email: dateUser?[1], name: dateUser?[2]);
     notifyListeners();
   }
  }
  void updateUser(User user)async{
    currentUser = user;
    await SharedPrefs.savedUserInInSharedPreferences(user);
  }
}