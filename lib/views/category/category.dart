import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/views/home/home.dart';
import 'package:cross_border_project/views/shopping-cart/shopping-cart.dart';
import 'package:cross_border_project/views/person/person.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './search.dart';
import './categoryContext.dart';

class CategoryPageClass extends StatefulWidget{
   CategoryPageClass({super.key});
  _CategoryPageClassState createState()=>_CategoryPageClassState();
}

class _CategoryPageClassState extends State<CategoryPageClass>{
   var dataList=[];
  @override
  void initState() {
      if(mounted){
        super.initState();
        request('category', 'get', null).then((value){
            var data = jsonDecode(value.toString());
          if(data['status']==200){
            setState(() {
              dataList = data['data'];
            });

          }
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('商品分类',style: TextStyle(color: Colors.black,fontSize: 17),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 1.sw,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.black12
                      )
                  )
              ),
              child: Padding(padding: const EdgeInsets.only(bottom: 5),child: SearchClass(),),
            ),
            dataList.length>0?CategoryContextClass(dataList:dataList):Text('')
          ],
        )
      ),
    );
  }
}