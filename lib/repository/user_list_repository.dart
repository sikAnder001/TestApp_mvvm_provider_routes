

import 'package:flutter_api_project_mvvm/data/network/BaseApiServices.dart';
import 'package:flutter_api_project_mvvm/data/network/NetworkApiService.dart';
import 'package:flutter_api_project_mvvm/model/user_list_model.dart';
import 'package:flutter_api_project_mvvm/res/app_url.dart';

class UserListRepository {
  BaseApiServices bsp=NetworkApiService();

  Future<UserListResponse> getUserList() async{
    try{
      dynamic response=await bsp.getApiResponse(AppUrl.userListUrl);
      return response=UserListResponse.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}