import 'dart:math';
import 'package:dio/dio.dart';
import './http_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';

Future request(url,method,formData)async{

  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;
  try{

    BaseOptions options = BaseOptions();
    options.headers['Authori-zation']=mainState.token;
    var response;
    Dio dio = new Dio(options);
    var requestUrl = '';
    if(url.contains(baseUrl)){
      requestUrl = url;
      print(url);
    }else{
      requestUrl = servicePath[url]!;
    }
    print('${servicePath[url]}');
    if(method=='post'){
      response = await dio.post(requestUrl,data:formData!=null?formData:{});
    }else{
      response = await dio.get(requestUrl,queryParameters:formData!=null?formData:{});
    }

    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception('后端接口异常..');
    }
  }on DioError catch(e){
    Fluttertoast.showToast(msg: e.message.toString(),toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,textColor: Colors.white,fontSize: 16.0);
     // print('${e.message}');
  }
}