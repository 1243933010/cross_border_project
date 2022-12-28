import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';


Map menusMap = {
  '/pages/goods_cate/goods_cate':goCate,
  '/pages/users/user_get_coupon/index':couponPage,
  '/pages/extension/news_list/index':articlePage,
  '/pages/users/user_goods_collection/index':collectionPage,
  '/pages/users/user_address_list/index':addressClient

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
collectionPage(){
  Get.toNamed('/collection');
}
addressClient(){
  Get.toNamed('/addressClient');
}