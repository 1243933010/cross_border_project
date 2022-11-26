import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/views/home/home_swiper.dart';
import 'package:cross_border_project/common/network/index.dart';
import './menus.dart';
import './new.dart';
import './activity.dart';
import './coupons.dart';
import './recommend.dart';
import './controller.dart';
import 'package:cross_border_project/models/home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller c = Get.put(Controller());
  var imgList =[];
  var newsObj = {'img':'','list':[]};
  var activityData =[];
  @override
  void initState() {
    super.initState();
    getDefaultData();

  }
  getDefaultData() {
    request('getDiyDefault','get',null).then((value)async{
      var data = jsonDecode(value.toString());
      if(data['status']==200){
        if(mounted){
          c.defaultData = data['data'];
          var recommendData = await HomeFncClass().getRecommendList(c.defaultData['goodList']['aa']);
          setState(() {
            imgList=c.defaultData['menus']['default']['imgList']['list'];  //首页十个按钮入口
            newsObj = {'img':c.defaultData['news']['default']['imgUrl']['url'],
              'list': handelNewList(c.defaultData['news']['default']['newList']['list'])};
            activityData = c.defaultData['activity']['default']['imgList']['list'];
            couponsKey.currentState?.getCouponsList( c.defaultData['coupon']['default']['numConfig']['val']);
            recommendKey.currentState?.getRecommendList(recommendData);
          });
        }
      }
    });

  }
  @override
   handelNewList(arr){
    var list = [];
    var enumObj = {'/pages/news_list/index':''}; //映射对应路径页面
    for(int i = 0;i<(arr?.length??0);i++){
      list.add({'val':arr[i]['chiild'][0]['val'],'url':enumObj[arr[i]['chiild'][1]['val']]});
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,//隐藏下边框的线
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.deepOrange,
            ],begin: Alignment.bottomLeft,end: Alignment.topRight)
          ),
        ),
        title: Container(
          alignment: Alignment.bottomLeft,
          width: 400.w,
          // color: Colors.red,
          height: 30,
          // padding:const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
               Image.network(
                   'https://shop.zyjsl.com/uploads/attach/2022/10/20221014/7eb2256dcbc4a41fc80bc2390122edb4.png',
                    width: 30,
                    height: 30,
               ),
              const SizedBox(width: 20,),
              const Text('优质精选好物', style: TextStyle(fontSize: 17),),
            ],
          )
        ),
        centerTitle: false,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.white,Colors.grey]
        //   )
        // ),

        color: Colors.white,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeSwiper(),
                MenusClass(imgList:imgList),
                NewsClass(newsObj:newsObj),
                ActivityClass(activityData:activityData),
                CouponsClass(key:couponsKey),
                RecommendClass(key:recommendKey),

              ],
            ),
        ),
      )
    );
  }
}