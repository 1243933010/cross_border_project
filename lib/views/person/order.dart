import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 25,
        left: 35.w,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              alignment: Alignment.center,
              width: 680.w,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('订单中心',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const Expanded(child: Text('')),
                          Row(
                            children: const [
                              Text('查看全部',style: TextStyle(color: Colors.grey),),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 18,)
                            ],
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  [
                          Column(
                            children: const[
                              Icon(IconData(0xf01c4,fontFamily: 'wallet',matchTextDirection: true,),color: Colors.red,size: 25,),
                              Text('待付款')
                            ],
                          ),
                          Column(
                            children: const[
                              Icon(IconData(0xe619,fontFamily: 'receipt',matchTextDirection: true),color: Colors.red,size: 25,),
                              Text('待付款')
                            ],
                          ),
                          Column(
                            children:const [
                              Icon(IconData(0xe64f,fontFamily: 'express',matchTextDirection: true),color: Colors.red,size: 25,),
                              Text('待付款')
                            ],
                          ),
                          Column(
                            children:const [
                              Icon(IconData(0xf01c7,fontFamily: 'evaluate',matchTextDirection: true),color: Colors.red,size: 25,),
                              Text('待付款')
                            ],
                          ),
                          Column(
                            children: const[
                              Icon(IconData(0xe684,fontFamily: 'refund',matchTextDirection: true),color: Colors.red,size: 25,),
                              Text('待付款')
                            ],
                          ),
                        ],
                      ),
                      )
                    ],
                  )),
            )));
  }
}
