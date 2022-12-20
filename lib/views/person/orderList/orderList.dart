import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import './positionInfo.dart';
import './list.dart';
import 'package:cross_border_project/widgets/Toast.dart';
class OrderListClass extends StatefulWidget{
  @override
  _OrderListClassState createState()=>_OrderListClassState();
}

class _OrderListClassState extends State<OrderListClass>{
  // print('${Get.pa}')
  var params = {
    'type':Get.arguments['type'],
    'page':1,
    'limit':10
  };
  var orderData = {};
  var orderListArr = [];
  @override
  getOrderList(){
    request(orderList(params['type'],params['page'],params['limit']), 'get', null).then((val){
      var data = jsonDecode(val.toString());
      // print(data);
      if(data!=null){
        if(data['status']==200){
          setState(() {
            orderListArr = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
      }
    });
  }
  getOrderData(){
    request('orderData', 'get', null).then((val){
      var data = jsonDecode(val.toString());
      // print(data);
      if(data!=null){
        if(data['status']==200){
          setState(() {
            orderData = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
      }
    });
  }
  changeIndex(int type){
    setState(() {
      params = {
        'type':type.toString(),
        'page':1,
        'limit':10
      };
    });
    getOrderList();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderData();
    getOrderList();
    print('${Get.arguments}');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('我的订单',style: TextStyle(color: Colors.black),),
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color:const Color.fromRGBO(245,245,245,1),
        child: ListView(
          children: [
            OrderInfoClass(orderData:orderData,changeIndex:changeIndex),
            ListClass(orderListArr:orderListArr)
          ],
        ),
      ),
    );
  }
}