import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListClass extends StatefulWidget{
  var orderListArr=[];
  ListClass({super.key,required this.orderListArr});
  @override
  _ListClassState createState()=>_ListClassState();
}


class _ListClassState extends State<ListClass>{
  @override
  Widget build(BuildContext context) {
    return widget.orderListArr.length>0?Container(
      child: Column(
        children: [
          for(var i=0;i<widget.orderListArr.length;i++)
            OrderDetailClass(detail:widget.orderListArr[i])
        ],
      ),
    ):Container(
      height: 500.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('https://sit.zyjsl.com/statics/images/empty-box.png',width: 350.w,),
            const Text('暂无订单')
          ],
        ),
      ),
    );
  }
}

class OrderDetailClass extends StatelessWidget{
  OrderDetailClass({super.key,required this.detail});
   TextStyle textStyle =  const TextStyle(
    fontSize: 16,
    color: Colors.red
  );
  var detail  ={};
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.only(top: 10,bottom: 10),
        child: Container(
          width: 700.w,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only( left: 10,right: 10),
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1,color: Colors.black12)
                        )
                    ),
                    child: Padding(
                      padding:const EdgeInsets.only(top: 5,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${detail['_add_time']}',style: const TextStyle(fontSize: 17),),
                          detail['shipping_type']==1&&detail['_status']['_type']==1? Text('待发货',style:textStyle,):
                          detail['shipping_type']==2&&detail['_status']['_type']==1? Text('待核销',style:textStyle,):
                          detail['_status']['_type']==2? Text('待收货',style:textStyle,):
                          detail['_status']['_type']==3? Text('待评价',style:textStyle,):
                          detail['_status']['_type']==4? Text('已完成',style:textStyle,):
                          detail['_status']['_type']==5&&detail['status']==0? Text('未核销',style:textStyle,):
                          detail['_status']['_type']==-2? Text('已退款',style:textStyle,):const Text('')
                        ],
                      ),
                    )
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1,color: Colors.black12)
                      )
                  ),
                  child: Padding(
                    padding:const EdgeInsets.only(top: 5,bottom: 5),
                    child: Column(
                      children: [
                       Column(
                         children: [
                           for(var j=0;j<detail['cartInfo'].length;j++)
                             CartDetailClass(cartDetail:detail['cartInfo'][j])
                         ],
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('共${detail['total_num']}件商品，总金额'),
                            Text('￥${detail['pay_price']}')
                          ],
                        )
                      ],
                    ),
                  )
                ),
               Padding(
                   padding:const EdgeInsets.only(top: 5,bottom: 5),
                   child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     ElevatedButton(
                       style: ButtonStyle(
                         // side: MaterialStateProperty.all(const BorderSide(width: 1,color: Colors.grey)),
                           backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(254,92,45,1)),
                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                       ),
                       onPressed: (){},
                       child:const Padding(
                           padding: EdgeInsets.only(left: 5,right: 5),
                           child: Text('查看详情',style: TextStyle(color: Colors.white),)),
                     )
                   ],
                 ),
               )
              ],
            ),
          )
        ),
    );
  }
}


class CartDetailClass extends StatelessWidget{
  CartDetailClass({super.key,required this.cartDetail});
  var cartDetail = {};
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       ClipRRect(
         borderRadius: BorderRadius.circular(5),
         child:  Image.network('${cartDetail['productInfo']['image']}',width: 150.w,),
       ),
        Container(
          width: 400.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${cartDetail['productInfo']['store_name']}',overflow: TextOverflow.ellipsis,),
              Text('${cartDetail['productInfo']['store_info']}',overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('￥${cartDetail['sum_price']}'),
            Text('X${cartDetail['cart_num']}'),
          ],
        )
      ],
    );
  }
}