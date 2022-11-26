import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/common/network/index.dart';

class ShopListClass extends StatefulWidget {
  var shopList = [];
  ShopListClass({super.key,required this.shopList});

  _ShopListClassState createState()=>_ShopListClassState();


}

class _ShopListClassState extends State<ShopListClass>{
   List recommendShopList = [];
  @override
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
  @override
  void initState() {
    super.initState();
    getCartList();
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
                  Padding(padding:const EdgeInsets.only(left: 5),child: Text('${widget.shopList.length}',style: const TextStyle(fontSize: 19),),)
                ],
              ),
              widget.shopList.isNotEmpty?OutlinedButton(
                  style:  const ButtonStyle(
                    // textStyle: MaterialStatePropertyAll(),
                    // backgroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                  onPressed: (){},
                  child: const Text('管理')
              ):const Text('')
            ],
          ),),
          Container(width: double.infinity,height: 12.h,color: Colors.grey[200],),
         Container(
           // color: Colors.yellow,
           height: 850.h,
           child: ListView(
             shrinkWrap: true,
             children: [
               CartListClass(shopList:widget.shopList),
               RecommendShopClass(shopList:widget.shopList,recommendShopList:recommendShopList),
             ],
           ),
         )
        ],
      ),
    );
  }
}


class CartListClass extends StatelessWidget{
  List shopList;
  CartListClass({super.key,required this.shopList});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: shopList.isNotEmpty?Text('11'):
      Image.network('https://sit.zyjsl.com/statics/images/no-thing.png',width: 500.w,height:400.h, fit: BoxFit.fill,),
    );
  }
}



class RecommendShopClass extends StatelessWidget{
  var recommendShopList;
  List shopList;
  RecommendShopClass({super.key,required this.shopList,required this.recommendShopList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
        // height: 1000.h,
        // color: Colors.red,
        child: shopList.isEmpty?
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