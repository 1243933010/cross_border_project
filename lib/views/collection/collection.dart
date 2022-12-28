import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/common/network/http_config.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:cross_border_project/widgets/HotRadio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './collectionListItem.dart';
import 'package:cross_border_project/widgets/loadRecord.dart';
import 'package:cross_border_project/common/network/index.dart';

class CollectionClass extends StatefulWidget{
  CollectionClass({super.key});
  @override
  _CollectionClassState createState()=>_CollectionClassState();
}

class _CollectionClassState extends State<CollectionClass>{
  final ScrollController _controller = ScrollController();
  Map requestObj={'page':1,'limit':8 };
  bool loadStatus = false;
  bool scrollStatus = true;
  Map collectionMap = {'count':0,'list':[]};
  bool clickShowBool = false;
  Map footerData = {'allStatus':false,'count':0};
  getList(){
    request(collectUser(requestObj['page'],requestObj['limit']), 'get', null).then((val){
      if(val!=null){
        var data = jsonDecode(val.toString());
        var collectionMapCopy = collectionMap;
        if(data['status']==200){
          collectionMapCopy['count'] = data['data']['count'];
          if(data['data']['list'].length>0){
            for(var i = 0;i<data['data']['list'].length;i++){
              data['data']['list'][i]['checkBool'] = false;
              collectionMapCopy['list'].add( data['data']['list'][i]);
            }
            setState(() {
              scrollStatus = true;
            });
          }else{
            var num = requestObj['page']+1;
            setState(() {
              requestObj = {'page':num-1,'limit':8 };
            });
          }
          setState(() {
            collectionMap = collectionMapCopy;
            loadStatus = false;
          });
          // print(collectionMap);
          return false;
        }
        errorInfo(data['msg']);
      }
    });
  }
  changeBool(bool status){
    setState(() {
      clickShowBool = status;
    });
  }
  updateMsg(scrollNum,size,len){
    //已滚动高度+(当前屏幕高度-刘海高度-AppBar高度-底部padding高度)>=listview内的组件高度
    //scrollNum 已滚动高度  screenHeight当前屏幕高度  mq.padding.top刘海高度 mq.padding.bottom底部padding高度
    //70.h + len*size 组件内高度  70.h是头部管理组件高度，10是管理组件上下边距
    MediaQueryData mq = MediaQuery.of(context);
    var screenHeight = mq.size.height;//当前屏幕高度
    if((scrollNum+screenHeight-mq.padding.top-mq.padding.bottom)>=size*len+70.h+10&&scrollStatus){
      print('触发了--');
      var num = requestObj['page']+1;
      setState(() {
        loadStatus = true;
        scrollStatus = false;
        requestObj={'page':num,'limit':8 };
      });

      getList();
    }
  }
  changeItemRadio(mapData){
    var list = collectionMap['list'];
    list[mapData['index']]['checkBool'] = mapData['status'];
    mapData['status']? footerData['count']=footerData['count']+1: footerData['count']=footerData['count']-1;
    footerData['count']==collectionMap['count']? footerData['allStatus'] = true:footerData['allStatus'] = false;
    setState(() {
      collectionMap = {
        'count': collectionMap['count'],
        'list':list
      };
    });
  }
  changeAllStatus(bool status){
    for(var i = 0;i<collectionMap['list'].length;i++){
      collectionMap['list'][i]['checkBool'] = status;
    }
    status?footerData['count'] = collectionMap['list'].length:0;
    footerData['allStatus'] = status;
    setState(() { });
  }
  noticePrenet(){
    requestObj={'page':1,'limit':8 };
    collectionMap = {'count':0,'list':[]};
    setState(() {  });
    getList();
  }
  @override
  void initState() {
    super.initState();
    getList();
    _controller.addListener(() {
      updateMsg(_controller.offset,180.w,collectionMap['list'].length);
    });
  }
  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title:  const Text('收藏商品',style: TextStyle(color: Colors.black),),
      elevation: 0,
      iconTheme:const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    );
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5,right: 5),
            child: ListView(
              controller: _controller,
              children: [
                CollectionHeader(count:collectionMap['count'],clickShowBool:clickShowBool,changeBool:changeBool),
                Padding(padding: const EdgeInsets.only(bottom: 40),child: Column(
                  children: [
                    for(var i = 0;i<collectionMap['list'].length;i++)
                      CollectionListItem(item:collectionMap['list'][i],clickShowBool:clickShowBool,index:i,changeItemRadio:changeItemRadio)
                  ],
                ),),
                loadStatus?LoadRecordClass(width: 100.w,):const Text(''),
              ],
            ),),
          Positioned(
            bottom: 0,
            left: 0,
            child:clickShowBool? CollectionFooter(footerData:footerData,changeAllStatus:changeAllStatus,list:collectionMap['list'],noticePrenet:noticePrenet):const Text(''),
          )
        ],
      )
    );
  }
}


class CollectionHeader extends StatefulWidget{
  var count;
  bool clickShowBool = false;
  var changeBool;
  CollectionHeader({super.key,required this.count,required this.clickShowBool,required this.changeBool});
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
      child: Container(
        height: 70.h,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1,color: Color.fromRGBO(242,242,242,1))
          )
        ),
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
                widget.changeBool(!widget.clickShowBool);
              },
              child:widget.clickShowBool?Text('取消',style: textStyle2,): Text('管理',style: textStyle2,) ,
            )
          ],
        ),
      ),
    );
  }
}


class CollectionFooter extends StatefulWidget{
  Map footerData = {};
  var changeAllStatus;
  var noticePrenet;
  List list = [];
   CollectionFooter({
     super.key,
     required this.footerData,
     required this.changeAllStatus,
     required this.list,
     required this.noticePrenet
   });

  @override
  _CollectionFooterState createState()=>_CollectionFooterState();
}

class _CollectionFooterState extends State<CollectionFooter>{
  Color hotBorder =const Color.fromRGBO(242,242,242,1);
  Icon checkTrue = const Icon(
    IconData(
      0xf01b6,
      fontFamily: 'checkRadio',
      matchTextDirection: true,
    ),
    color: Colors.red,
    size: 31,
  );
  changeRadio(bool status){
    widget.changeAllStatus(status);
  }
  delDataFnc(){
    var arr = [];
    for(var i = 0;i<widget.list.length;i++){
      if(widget.list[i]['checkBool']){
        arr.add(widget.list[i]['pid'].toString());
      }
    }
    request('collectDel', 'post', {'category':'product','id':arr}).then((val){
      var data = jsonDecode(val.toString());
      print(data);
      if(data['status']==200){
        widget.noticePrenet();
      }
      errorInfo(data['msg']);
    });
  }
  @override
  Widget build(BuildContext context) {
    // print(widget.footerData);
    return Container(
      width: 750.w,
      decoration:const BoxDecoration(
        color: Color.fromRGBO(250,250,250,1),
          // color: Colors.red,
          border: Border(
              top: BorderSide(width: 1,color: Color.fromRGBO(242,242,242,1))
              // top: BorderSide(width: 1,color: Colors.red)
          )
      ),
      child: Padding(
        padding:const EdgeInsets.only(left: 7,right: 7,top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HotRadioClass(radioBool:widget.footerData['allStatus'],changeRadio:changeRadio,hotBorder:hotBorder,checkTrue:checkTrue),
                Text('全选(${widget.footerData['count']})'),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))
                ),
                onPressed: (){
                  // print(widget.list);
                  delDataFnc();
                },
                child:const Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child:  Text('取关',style: TextStyle(color: Color.fromRGBO(255,87,34,1)),),
                )
            ),
          ],
        ),
      )
    );
  }
}