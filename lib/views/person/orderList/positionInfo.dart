import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderInfoClass extends StatefulWidget {
  var orderData = {};
  var changeIndex;
  OrderInfoClass({super.key,required this.orderData,required this.changeIndex});
@override
  _OrderInfoClassState createState()=>_OrderInfoClassState();
}

class _OrderInfoClassState extends State<OrderInfoClass>{
  var tabList = [
    {'title':'待付款','count':0,'type':0},
    {'title':'待发货','count':0,'type':1},
    {'title':'待收货','count':0,'type':2},
    {'title':'待评价','count':0,'type':3},
    {'title':'已完成','count':0,'type':4},
  ];
  var index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      tabList = [
        {'title':'待付款','count':widget.orderData['unpaid_count'],'type':0},
        {'title':'待发货','count':widget.orderData['unshipped_count'],'type':1},
        {'title':'待收货','count':widget.orderData['received_count'],'type':2},
        {'title':'待评价','count':widget.orderData['evaluated_count'],'type':3},
        {'title':'已完成','count':widget.orderData['complete_count'],'type':4},
      ];
    });
    return Container(
      height: 410.h,
      child: Stack(
        children: [
          Container(
              color: const Color.fromRGBO(254,92,45,1),
              height: 300.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const  Padding(padding: EdgeInsets.only(bottom: 15),child: Text('订单信息',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),),
                        Text('消费订单：${widget.orderData['order_count']}总消费：￥${widget.orderData['sum_price']}',style: const TextStyle(color: Colors.white),),
                      ],
                    ),
                    Image.asset('imgs/order_time.png',width: 130.w,)
                  ],
                ),
              )
          ),
          Positioned(
              bottom: 0,
              left: 25.w,
              child: Container(
                color: Colors.white,
                width: 700.w,
                height: 200.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for(var i = 0;i<tabList.length;i++)
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index = i;
                        });
                        widget.changeIndex(i);
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                            border: Border(
                                bottom:index==i?const BorderSide(width: 2,color:Colors.red):const BorderSide(width: 2,color: Colors.white)
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            Text('${tabList[i]['title']}',style: const TextStyle(fontSize: 17),),
                            Text('${tabList[i]['count']}',style: TextStyle(fontWeight: index==i?FontWeight.bold:FontWeight.normal,fontSize: 16),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}