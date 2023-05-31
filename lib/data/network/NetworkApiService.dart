
import 'dart:convert';
import 'dart:io';

import 'package:flutter_api_project_mvvm/data/network/BaseApiServices.dart';

import '../api_exceptions.dart';

import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{

  @override
  Future getApiResponse(String url) async{

    dynamic responseJson;

    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async{
    dynamic responseJson;

    try{
      http.Response response= await http.post(
        Uri.parse(url),
        body: data
      ).timeout(const Duration(seconds: 10));

      responseJson=returnResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default : throw FetchDataException("Error occurred while communication with server with status code:${response.statusCode}");
    }
  }

}