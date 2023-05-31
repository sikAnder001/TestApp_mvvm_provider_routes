import 'package:flutter/cupertino.dart';
import 'package:flutter_api_project_mvvm/data/response/api_response.dart';
import 'package:flutter_api_project_mvvm/model/user_list_model.dart';
import 'package:flutter_api_project_mvvm/repository/user_list_repository.dart';

class UserListViewModel with ChangeNotifier {
  final userRepo = UserListRepository();

  ApiResponse<UserListResponse> userList = ApiResponse.loading();

  setUserList(ApiResponse<UserListResponse> response) {
    userList = response;
    notifyListeners();
  }

  Future<void> getUserList() async {

    setUserList(ApiResponse.loading());
    userRepo.getUserList().then((value) {
      setUserList(ApiResponse.success(value));
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}
