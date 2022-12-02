import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleTabClass extends StatefulWidget{
  var hotList = [];
  var articleList =[];
  var index = 0;
  ArticleTabClass({super.key,required this.articleList,required this.hotList});
  @override
  _ArticleTabClassState createState()=>_ArticleTabClassState();
}

class _ArticleTabClassState extends State<ArticleTabClass>{

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: 710.w,
        child: Column(
          children: [
            Container(
              decoration:const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1,color: Colors.black12)
                  )
              ),
              child: Padding(
                padding:const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    for(var i = 0;i<widget.articleList.length;i++)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.index = i;
                          });
                        },
                        child: Padding(
                          padding:const EdgeInsets.only(right: 15),
                          child:Container(
                            // width: 80.w,
                            height: 65.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                i==widget.index? Text('${widget.articleList[i]['title']}',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),):
                                Text('${widget.articleList[i]['title']}',style: const TextStyle(fontSize: 17,color: Colors.grey),),
                                i==widget.index? Container(
                                  width: 50.w,
                                  height: 2,
                                  color:Colors.red,
                                ):Container(height: 0,)
                              ],
                            ),
                          )
                        ),
                      )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}