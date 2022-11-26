import 'dart:ffi';

import 'package:get/get.dart';
import 'package:cross_border_project/states/mian.dart';
class GlobalStateController extends GetxController{
  MainState state = MainState();
  changeBottomBarIndex(int index){
    state.bottombar_index.value = index;
  }
  changeToken(String token){
    state.token.value = token;
  }
  setUserInfo(Map str){
    state.userInfo.value = str;
  }
  setLoginBool(bool bools){
    state.loginBool.value = bools as bool;
  }
}