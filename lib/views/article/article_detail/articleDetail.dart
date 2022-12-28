import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

class ArticleDetailClass extends StatefulWidget{
  ArticleDetailClass({super.key});

  @override
  _ArticleDetailClassState createState()=>_ArticleDetailClassState();
}

class _ArticleDetailClassState extends State<ArticleDetailClass>{
  var title = '';
  Map itemObj = {
    'title':''
  };
  getDetail(String id){
    request(articleDetail(id), 'get', null).then((val){
      // print(val);
      if(val!=null){
        Map data = jsonDecode(val.toString());
        if(data['status']==200){
          setState(() {
            itemObj = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
      }

    });
  }

  @override
  void initState() {
    super.initState();
    String id = Get.arguments['id'].toString();
    if(id.isNotEmpty){
      getDetail(id);
    }
  }
  @override
  Widget build(BuildContext context) {
    print(itemObj['title']);
    return Scaffold(
      appBar: AppBar(
        title:  Text('${itemObj['title']}',style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color:const Color.fromRGBO(255,255,255,1),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('${itemObj['title']}',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                children: [
                  Padding(padding:const EdgeInsets.only(right: 10),child: Text('${itemObj['catename']}'),),
                  Padding(padding:const EdgeInsets.only(right: 10),child: Text('${itemObj['add_time']}'),),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(right: 3),child: Icon(Icons.remove_red_eye_outlined),),
                      Text('${itemObj['visit']}')
                    ],
                  )
                ],
              ),),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child:Row(
                  children: [
                    itemObj['content']!=null?Expanded(child: Html(
                      data: itemObj['content'],
                      style: const {},
                    )):const Text('')
                  ],
                ) ,
              )
            ],
          ),
        )
      ),
    );
  }
}