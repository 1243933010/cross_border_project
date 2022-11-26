import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './shop-list.dart';


class ShoppingCartPageClass extends StatefulWidget {
  ShoppingCartPageClass({super.key});

  _ShoppingCartPageClassState createState() => _ShoppingCartPageClassState();
}

class _ShoppingCartPageClassState extends State<ShoppingCartPageClass> {
 var shopList = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '购物车',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromRGBO(245, 245, 245, 1),
          child: Column(
            children: [
              LabelTextClass(),
              ShopListClass(shopList:shopList),
            ],
          ),
        ));
  }
}

class LabelTextClass extends StatelessWidget {
   static const textSize =  TextStyle(
      color: Colors.grey, fontSize: 15
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
              Text(
                '正品保证',
                style: textSize,
              )
            ],
          ),
          Row(
            children: const [
              Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
              Text(
                '所有商品精挑细选',
                style: textSize,
              )
            ],
          ),
          Row(
            children: const [
              Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
              Text(
                '售后无忧',
                style:textSize,
              )
            ],
          )
        ],
      ),
    );
  }
}
