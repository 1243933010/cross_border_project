import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/common/network/index.dart';
import './selectShop.dart';

class ShopListClass extends StatefulWidget {
  ShopListClass({super.key});
  @override
  _ShopListClassState createState()=>_ShopListClassState();


}

class _ShopListClassState extends State<ShopListClass>{
   List recommendShopList = [];
   var shopList = [];   //当前购物车信息
   var shopConut = 0;   //购物车商品总数量
   var btnClickStatus = false;   //底部是否切换成删除按钮
   var allCheckStatus = true;

  @override

  getShopNum(){
    request('cartCount', 'get', {'numType':'0'}).then((val){
      var data = jsonDecode(val.toString());
      if(data['status']==200){
        setState(() {
          shopConut = data['data']['count'];
        });

      }
    });
  }

  getCartList(){
    request('productHot', 'get', {'page':'1','limit':'10'}).then((value){
      var data = jsonDecode(value.toString());
      // print(data);
      if(data['status']==200){
        setState(() {
          recommendShopList = data['data'];
        });
      }

    });
  }


  getUserCartList(){  //获取当前用户购物车信息
    request('cartList', 'get', {'page':'1','limit':'20','status':'1'}).then((res){
      var data = jsonDecode(res.toString());
      if(data['status']==200){
        if(data['data']['valid']!=null){
          for(var i = 0;i< data['data']['valid'].length;i++){
            data['data']['valid'][i]['checkBool'] = true;
          }
          setState(() {
            shopList = data['data']['valid'];
          });
        }
      }
    });
  }
   checkAll(status){
    // print(status);
    var arr = shopList;
    for(var i = 0;i<arr.length;i++){
      arr[i]['checkBool'] = status;
    }
    setState(() {
      shopList=arr;
      allCheckStatus = status;
    });
   }
   changeItem(status,index){
     var arr = shopList;
     arr[index]['checkBool'] = status;
     var bool = true;
     for(var i = 0;i<arr.length;i++){
       if(arr[i]['checkBool']==false){
         bool = false;
       }
     }
     setState(() {
       shopList=arr;
       allCheckStatus = bool;
     });
   }


  @override
  void initState() {
    super.initState();
    getCartList();
    getUserCartList();
    getShopNum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(padding:const EdgeInsets.only(top: 5,bottom: 5,left: 10,right:10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('购物数量',style: TextStyle(fontSize: 17),),
                  Padding(padding:const EdgeInsets.only(left: 5),child: Text('${shopConut??0}',style: const TextStyle(fontSize: 19),),)
                ],
              ),
              shopConut>0?OutlinedButton(
                  style:   OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: (){
                    setState(() {
                      btnClickStatus = !btnClickStatus;
                    });
                  },
                  child:!btnClickStatus? const Text('管理',style: TextStyle(color: Colors.grey),):const Text('取消',style: TextStyle(color: Colors.grey),)
              ):const Text('')
            ],
          ),),
          Container(width: double.infinity,height: 12.h,color: Colors.grey[200],),
         Container(
           // color: Colors.yellow,
           height: 810.h,
           child: Column(
             // shrinkWrap: true,
             children: [
               shopConut>0?Container(
                 // color: Colors.red,
                width: 750.w,
                height: 810.h,
                child: Stack(
                  // alignment: Alignment.center,
                  children:  [
                    CartListClass(shopConut:shopConut,shopList:shopList,changeItemFnc:changeItem,updateShop:getUserCartList),
                    RecommendShopClass(shopConut:shopConut,recommendShopList:recommendShopList),
                    Positioned(bottom: 0,child:  AllPriceClass(shopList:shopList,btnClickStatus:btnClickStatus,checkAll:checkAll,allCheckStatus:allCheckStatus,updateShop:getUserCartList),)
                  ],
                ),
              ):const Text('')
             ],
           ),
         )
        ],
      ),
    );
  }
}


class CartListClass extends StatelessWidget{
  int shopConut;
  var shopList;
  var changeItemFnc;
  var updateShop;
  CartListClass({super.key,required this.shopConut,required this.shopList,required this.changeItemFnc,required this.updateShop});

  @override
  changeItem(status,index){
    changeItemFnc(status,index);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: shopConut>0?SelectShopClass(shopList:shopList,changeItemFnc:changeItem,updateShop:updateShop):
      Image.network('https://sit.zyjsl.com/statics/images/no-thing.png',width: 500.w,height:400.h, fit: BoxFit.fill,),
    );
  }
}



class RecommendShopClass extends StatelessWidget{
  var recommendShopList;
  int shopConut;
  RecommendShopClass({super.key,required this.shopConut,required this.recommendShopList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
        // height: 1000.h,
        // color: Colors.red,
        child: shopConut==0?
       Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: const[
               Text('--------'),
               Padding(padding: EdgeInsets.only(left: 10,right: 10),child:  Text('热门推荐'),),
               Text('--------'),
             ],
           ),
           Padding(
             padding: const EdgeInsets.only(left: 30,right: 30),
             child: GridView(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 1,
                 mainAxisSpacing:30,
                 crossAxisSpacing: 2
               ),
               children: recommendShopList.map<Widget>((val){
                 return  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    ClipRRect(borderRadius: BorderRadius.circular(40),child:  Image.network('${val['image']}',width: 250.w,height: 250.w,),),
                     Text('${val['store_name']}',overflow: TextOverflow.ellipsis,),
                     Text('${val['price']}',textAlign: TextAlign.left,)
                   ],
                 );
               }).toList(),
             ),
           )
         ],
       ):const Text(''),
    );
  }
}