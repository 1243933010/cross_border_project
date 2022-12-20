import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import 'package:get/get.dart';

class ArticleTabClass extends StatefulWidget{
  var hotList = [];
  var articleList =[];
  var index = 0;
  ArticleTabClass({super.key,required this.articleList,required this.hotList});
  @override
  _ArticleTabClassState createState()=>_ArticleTabClassState();
}

class _ArticleTabClassState extends State<ArticleTabClass>{
  var listContext = [];
  var object = {
    "page":1,
    "limit":10,
     'id':0
  };
  @override
  getLitstContext(int index){
    if(index==0){
      setState(() {
        listContext = widget.hotList;
      });
    }else{
      if(widget.articleList[index]['children'].length>0){
        getArticleList(widget.articleList[index]['children'][0]['id']);
      }else{
        getArticleList(widget.articleList[index]['id']);
      }

    }
  }

  getArticleList(int id){
    setState(() {
      object={ "page":1,"limit":10,'id':id};
    });
    request(articleList(id,object['page']!,object['limit']!), 'get', null).then((val){
      var data = jsonDecode(val.toString());
      print(data);
      if(data !=null){
        if(data['status']==200){
          setState(() {
            listContext = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
        return false;
      }

    });
  }
  clickItem(item){
    // print(item);
    Get.toNamed('/articleDetail',arguments: {'id':item['id']});
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.index==0){
      setState(() {
        listContext = widget.hotList;
      });
    }
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
                          getLitstContext(i);
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
            ),
            SizedBox(
              height: 630.h,
              // color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView(
                  children: [
                    for(var i =0;i<listContext.length;i++)
                      GestureDetector(
                        onTap:(){
                          clickItem(listContext[i]);
                        },
                        child: Container(
                          height: 200.h,
                          // color: Colors.red,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1,color: Colors.black12)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${listContext[i]['synopsis']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text('${listContext[i]['add_time']}',style: TextStyle(color: Colors.grey),)
                                  ],
                                ),
                                listContext[i]['image_input'].length>0?Image.network('${listContext[i]['image_input'][0]}'):Text('')
                              ],
                            ),
                          )
                        )
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