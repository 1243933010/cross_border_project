import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoutiquePageClass extends StatefulWidget{
  BoutiquePageClass({super.key});
  _BoutiquePageClassState createState()=>_BoutiquePageClassState();
}

class _BoutiquePageClassState extends State<BoutiquePageClass>{
  var banner = [];
  var list =[];
  @override
  getGroomList(id){
    request(groomList(id), 'get', {'page':'1','limit':'8'}).then((value){
      var data = jsonDecode(value.toString());
     if(data!=null){
       if(data['status']==200){
         setState(() {
           banner = data['data']['banner'];
           list = data['data']['list'];
         });
         return false;
       }
       errorInfo(data['msg']);
       return false;
     }
    });
  }
  @override
  void initState() {
    super.initState();
    var argument = Get.arguments;
    getGroomList(argument['id']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
        title:const Text('精品推荐',style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,

      ),
      body: ListView(
        children: [
          banner.isNotEmpty?SizedBox(
            width: double.infinity,
            height: 400.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Swiper(
                autoplay:true,
                scale: 0.9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                    },
                    child: Image.network(
                      banner[index]["img"],
                      fit: BoxFit.fill,
                    ),);
                },
                itemCount:  banner.length,
                pagination: const SwiperPagination(),
                // control: SwiperControl(),
              ),
            ),
          ):const Text(''),
          Column(
            children: [
              Column(
                children:  list.map<Widget>((val){
                  return Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                    child: SizedBox(
                      height: 160.h,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network('${val['image']}',width: 160.w,height: 160.w,),
                          ),
                          Padding(padding:const EdgeInsets.only(left: 10),
                            child: SizedBox(
                            width: 530.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${val['store_name']}',overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 18),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('￥${val['price']}',style:const TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        (val['vip_price']!=0)?Text('vip价格${val['vip_price']}'):const Text(''),
                                        Text('已售${val['sales']}${val['unit_name']}')
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),)
                        ],
                      ),
                    ),
                  );
                }).toList()
              )
            ],
          )
        ],
      ),
    );
  }
}