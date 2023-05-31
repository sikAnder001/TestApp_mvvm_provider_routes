
import 'package:flutter_api_project_mvvm/data/network/BaseApiServices.dart';
import 'package:flutter_api_project_mvvm/data/network/NetworkApiService.dart';
import 'package:flutter_api_project_mvvm/res/app_url.dart';

class AuthRepository{

  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response=await apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }

}