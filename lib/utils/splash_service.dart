

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes_name.dart';

import '../model/user_model.dart';
import '../view_model/user_view_model.dart';

class SplashService{

  Future<UserModel> getUserData()=> UserViewModel().getUser();

  void checkAuth(BuildContext context)async{
    getUserData().then((value) async {
      debugPrint(value.token);
      if(value.token =='null' || value.token==''){
        await Future.delayed(const Duration(seconds: 4));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 4));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}