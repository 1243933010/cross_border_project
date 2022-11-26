import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';


Map menusMap = {
  '/pages/goods_cate/goods_cate':goCate
};
 goCate(){
  final globalStateController = Get.put(GlobalStateController());
  // var mainState = Get.find<GlobalStateController>().state;
  print('111');
  globalStateController.changeBottomBarIndex(1);
}