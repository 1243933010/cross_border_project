import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class CouponPageClass extends StatefulWidget {
  CouponPageClass({super.key});

  @override
  _CouponPageClassState createState() => _CouponPageClassState();
}

class _CouponPageClassState extends State<CouponPageClass> {
  var couponsInfo = {'type': '0', 'page': '1', 'limit': '10'};
  var tabArr = [
    {'title': '通用券'},
    {'title': '品类券'},
    {'title': '商品券'},
  ];
  var couponsList = [];
  var index = 0;

  @override
  void initState() {
    super.initState();
    getCouponsList();
    print(MediaQueryData.fromWindow(window).padding.top);
  }

  getCouponsList() {
    request('getCouponsList', 'get', couponsInfo).then((val) {
      var data = jsonDecode(val.toString());
      if (data != null) {
        if (data['status'] == 200) {
          setState(() {
            couponsList = data['data']['list'];
          });
          return false;
        }
        errorInfo(data['msg']);
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            '领取优惠券',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 80.h,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var i = 0; i < tabArr.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  index = i;
                                  couponsInfo['type'] = i.toString();
                                  couponsInfo['page'] = '1';
                                });
                                getCouponsList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: index == i ? 2 : 0,
                                            color: Colors.red))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text('${tabArr[i]['title']}'),
                                ),
                              ),
                            )
                        ]),
                  )),
              Container(
                height: 1065.h,
                // color: Colors.red,
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                          children: couponsList.map<Widget>((val) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 200.h,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    width: 200.w,
                                    color: val['is_use'] != true &&
                                            val['is_use'] != 2
                                        ? Color.fromRGBO(232, 183, 115, 1)
                                        : Color.fromRGBO(204, 204, 204, 1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              '￥',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  color: Colors.white),
                                            ),
                                            Text('${val['coupon_price']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.white))
                                          ],
                                        ),
                                        val['use_min_price'] == 0
                                            ? const Text(
                                                '无门槛',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                '满${val['use_min_price']}元可用',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 500.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 120.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.red),
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Center(
                                                  child: val['type'] == 0
                                                      ? const Text('通用券')
                                                      : val['type'] == 1
                                                      ? const Text('品类券')
                                                      : const Text('商品券'),
                                                )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  '${val['coupon_title']}',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              val['coupon_time'] == 0 ||
                                                      val['coupon_time'] == null
                                                  ? const Text('')
                                                  : Text(
                                                      '领取后${val['coupon_time']}天可用',
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 150.w,
                                                  height: 45.h,
                                                  color:val['is_use']==true||val['is_use']==2? Color.fromRGBO(204,204,204,1):Color.fromRGBO(238,192,128,1),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.center,
                                                    children: [
                                                      val['is_use'] == true
                                                          ? const Text('已领取',style: TextStyle(color: Colors.white),)
                                                          : val['is_use'] == 2
                                                              ? const Text('已领完',style: TextStyle(color: Colors.white))
                                                              : GestureDetector(
                                                                  child:const Text( '立即领取',style: TextStyle(color: Colors.white)),)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
