import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'dart:convert';

GlobalKey<_CouponsClassState> couponsKey = GlobalKey();

class CouponsClass extends StatefulWidget {
  const CouponsClass({super.key});

  _CouponsClassState createState() => _CouponsClassState();
}

class _CouponsClassState extends State<CouponsClass> {
  var couponsList = [];

  // @override
  // initState() {
  //   super.initState();
  // }

  //获取首页优惠券数据
  getCouponsList(String str) {
    request('getCoupons', 'get', {'type': '-1', 'num': str}).then((value) {
      var data = jsonDecode(value.toString());
      if (data['status'] == 200) {
       if(mounted){
         setState(() {
           couponsList = data['data'];
         });
       }
        return false;
      }
    });
  }

  //点击了更多，子组件通信父组件
  @override
  handleMore(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(245, 245, 245, 1),
      child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  CouponsTopClass(
                    handleMore: handleMore,
                  ),
                  couponsList.length>0?CouponsContextClass(couponsList: couponsList):Text(''),
                ],
              ),
            ),
          )),
    );
  }
}

//头部文字抽取出来
class CouponsTopClass extends StatelessWidget {
  final handleMore;

  const CouponsTopClass({super.key, required this.handleMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                '优惠券',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '领取今日好券',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () => handleMore('11'),
            child: Row(
              children: const [
                Text(
                  '更多',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey)
              ],
            ),
          )
        ],
      ),
    );
  }
}

//抽取内容样式
class CouponsContextClass extends StatelessWidget {
  final List couponsList;

  const CouponsContextClass({super.key, required this.couponsList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          //动态创建一个List<Widget>
          children:
              couponsList.map((c) => CouponsContextBkClass(info: c)).toList(),
        ),
        // child: CouponsContextBkClass(),
      ),
    );
  }
}

//背景图片样式抽取出来
class CouponsContextBkClass extends StatelessWidget {
  final info;

  const CouponsContextBkClass({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('imgs/coupon_bk.png'))),
            child: SizedBox(
              width: 134.4,
              height: 64,
              // color: Colors.yellow,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        const Text(
                          '￥',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text('${info['coupon_price']}',
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 2),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: Colors.red[500],
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Text('满${info['use_min_price']}可用',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
