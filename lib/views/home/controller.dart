import 'package:get/get.dart';
class Controller extends GetxController{
  var count = 0.obs;
  List<Map> swipterList = [
    {
      "url": "https://shop.zyjsl.com/uploads/attach/2022/10/20221014/5f0b423c1cbc50f7341b4ecf33ebf28e.png"
    },
    {
      "url": "https://data44.wuht.net//uploads/attach/2022/01/20220115/d54f87813d22fc2ce2e6e231f3bcfae7.png"
    }
  ].obs;

  Map defaultData = {}.obs;
  List menusList = [].obs;
}

