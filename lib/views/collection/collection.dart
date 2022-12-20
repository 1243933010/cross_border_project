import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:cross_border_project/widgets/HotRadio.dart';

class CollectionClass extends StatefulWidget{
  CollectionClass({super.key});
  @override
  _CollectionClassState createState()=>_CollectionClassState();
}

class _CollectionClassState extends State<CollectionClass>{
  Map requestObj={'page':1,'limit':10 };
  Map collectionMap = {
    'count':0,
    'list':[]
  };
  bool clickShowBool = false;
  getList(){
    request(collectUser(requestObj['page'],requestObj['limit']), 'get', null).then((val){
      if(val!=null){
        var data = jsonDecode(val.toString());
        // print(data);
        if(data['status']==200){
          if(data['data']['list'].length>0){
            for(var i = 0;i<data['data']['list'].length;i++){
              data['data']['list'][i]['checkBool'] = false;
            }
          }
          setState(() {
            collectionMap = data['data'];
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
    getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏商品',style: TextStyle(color: Colors.black),),
        elevation: 0,
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Stack(
          children: [
            ListView(
              children: [
                CollectionHeader(count:collectionMap['count'],clickShowBool:clickShowBool),
                Column(
                  children: [
                    for(var i = 0;i<collectionMap['list'].length;i++)
                      CollectionListItem()
                  ],
                )
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              child: Text('111222')
            )
          ],
        )
      )
    );
  }
}


class CollectionHeader extends StatefulWidget{
  var count;
  bool clickShowBool = false;
  CollectionHeader({super.key,required this.count,required this.clickShowBool});
  @override
  _CollectionHeaderState createState()=>_CollectionHeaderState();
}

class _CollectionHeaderState extends State<CollectionHeader>{
  TextStyle textStyle1 = const TextStyle(fontSize: 16);
  TextStyle textStyle2 = const TextStyle(fontSize: 17,color: Colors.red);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('当前共',style: textStyle1),
              Text('${widget.count}',style:const TextStyle(color: Colors.red,fontSize: 17),),
              Text('件商品',style: textStyle1)
            ],
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                widget.clickShowBool = !widget.clickShowBool;
              });
            },
            child:widget.clickShowBool?Text('取消',style: textStyle2,): Text('管理',style: textStyle2,) ,
          )
        ],
      ),
    );
  }
}

class CollectionListItem extends StatefulWidget{
  CollectionListItem({super.key});
  @override
  _CollectionListItemState createState()=>_CollectionListItemState();
}

class _CollectionListItemState extends State<CollectionListItem>{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}