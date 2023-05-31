
import 'package:flutter_api_project_mvvm/data/response/status.dart';
import 'package:flutter_api_project_mvvm/model/user_list_model.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading(): status=Status.LOADING;
  ApiResponse.success(this.data): status=Status.SUCESS;
  ApiResponse.error(this.message): status=Status.ERROR;

 @override
  String toString() {
    return "Status: $status\n Message: $message\n Data: $data";
  }
}