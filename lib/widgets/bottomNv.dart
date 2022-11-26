import 'package:flutter/material.dart';
import 'package:cross_border_project/controller/main.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/views/home/home.dart';
import 'package:cross_border_project/views/category/category.dart';
import 'package:cross_border_project/views/shopping-cart/shopping-cart.dart';
import 'package:cross_border_project/views/person/person.dart';

class BottomNvClass extends StatefulWidget{
  BottomNvClass({super.key});
  _BottomNvClassState createState()=>_BottomNvClassState();
}

class _BottomNvClassState extends State<BottomNvClass>{
  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;
  List bodyPageList=[
    const MyHomePage(),
    CategoryPageClass(),
    ShoppingCartPageClass(),
    PersonPageClass()
  ];
  int index = 0;
  
  changeBottomNav(int ind){
    globalStateController.changeBottomBarIndex(ind);
    setState(() {
      index=ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'首页'),
          BottomNavigationBarItem(icon: Icon(Icons.add_card),label:'分类'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket),label:'购物车'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:'个人中心'),
        ],
        currentIndex: mainState.bottombar_index.value,
        onTap: (int index)=>changeBottomNav(index),
        fixedColor: Colors.red,
        // backgroundColor: Colors.yellow,
        unselectedItemColor:Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        type: BottomNavigationBarType.fixed,
      ),
      body:Obx(()=>bodyPageList[mainState.bottombar_index.value]) ,
    );
  }
}