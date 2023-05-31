import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_api_project_mvvm/model/user_model.dart';
import 'package:flutter_api_project_mvvm/repository/auth_repository.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_api_project_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    final uPreference=Provider.of<UserViewModel>(context,listen: false);
    setLoading(true);
    myRepo
        .loginApi(data)
        .then((value) => {
              setLoading(false),
              uPreference.saveUser(UserModel(token:value['token'].toString())),
              Utils.flushBarErrorMessage('Login Success', context),
              debugPrint(value.toString()),
              Navigator.pushNamed(context, RoutesName.home)
            })
        .onError((error, stackTrace) => {
              setLoading(false),
              Utils.flushBarErrorMessage(error.toString(), context),
              debugPrint(error.toString())
            });
  }
}
