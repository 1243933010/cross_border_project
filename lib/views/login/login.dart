import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_service.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginClass extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          '账户登录',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 120.h),
            child: Center(
              child: LoginFormClass(),
            ),
          )),
    );
  }
}

class LoginFormClass extends StatelessWidget {
  // final box = GetStorage();
  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  @override
  getUserInfo() async{
    final prefs = await SharedPreferences.getInstance();

    // print(mainState.token);
    request('user', 'get', null).then((res) async{
      var data = jsonDecode(res.toString());
      print(data);
      if(data['status']==200){
        await prefs.setString('userInfo', json.encode(data['data']));
        await prefs.setBool('loginBool', true);

        globalStateController.setUserInfo(data['data']);
        globalStateController.setLoginBool(true);
        Fluttertoast.showToast(msg: '获取信息成功',toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,textColor: Colors.white,fontSize: 16.0);
        Future.delayed(Duration(seconds: 2),(){
          Get.back();
        });
      }
    });
  }

  @override
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700.w,
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "输入手机号",
              // filled: true,
              // fillColor: Colors.red,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              border: _outlineInputBorder,
              focusedBorder: _outlineInputBorder,
              enabledBorder: _outlineInputBorder,
              disabledBorder: _outlineInputBorder,
              errorBorder: _outlineInputBorder,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400.w,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "输入验证码",
                      // filled: true,
                      // fillColor: Colors.red,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      border: _outlineInputBorder,
                      focusedBorder: _outlineInputBorder,
                      enabledBorder: _outlineInputBorder,
                      disabledBorder: _outlineInputBorder,
                      errorBorder: _outlineInputBorder,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Text('验证码'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 700.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.grey
                ),
                onPressed: () {},
                child:const Text('登录'),
              ),
            ),),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SizedBox(
            width: 700.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: ()=>getUserInfo(),
              child:const Text('一键登录'),
            ),
          ),)
        ],
      ),
    );
  }
}
