import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';


Map menusMap = {
  '/pages/goods_cate/goods_cate':goCate,
  '/pages/users/user_get_coupon/index':couponPage,
  '/pages/extension/news_list/index':articlePage
};
 goCate(){
  final globalStateController = Get.put(GlobalStateController());
  globalStateController.changeBottomBarIndex(1);
}
couponPage(){
   Get.toNamed('/coupon');
}
articlePage(){
  Get.toNamed('/article');
}