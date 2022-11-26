import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';

GlobalKey<_RecommendClassState> recommendKey = GlobalKey();

class RecommendClass extends StatefulWidget {
  const RecommendClass({super.key});

  _RecommendClassState createState() => _RecommendClassState();
}

class _RecommendClassState extends State<RecommendClass> {
  var recommendList=[];

  @override
  void initState() {
    super.initState();
  }

  @override
  handleMore() {}

  @override
  getRecommendList(value) {
    // print('%%%');
      var data = jsonDecode(value.toString());
      if (data['status'] == 200) {
          setState(() {
            recommendList = data['data']['list'];
          });
      }
  }

  @override
  Widget build(BuildContext context) {
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
                  RecommendTopClass(handleMore: handleMore),
                  Column(
                    children: recommendList.map<Widget>((f)=>RecommendContextClass(info:f)).toList(),
                  )
                  // RecommendContextClass(),
                ],
              ),
            ),
          )),
    );
  }
}

//头部文字抽取出来
class RecommendTopClass extends StatelessWidget {
  final handleMore;

  const RecommendTopClass({super.key, required this.handleMore});

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
                '促销精品',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '诚意推荐品质商品',
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

class RecommendContextClass extends StatelessWidget {
  final info;
  const RecommendContextClass({super.key,required this.info});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
      child:Container(
        decoration:const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Colors.black12
                )
            )
        ),
        height: 100,
        child: Padding(
          padding:const EdgeInsets.only(bottom: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  '${info['image']}',
                  width: 90,
                  height: 90,
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${info['store_name']}',
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 17),
                        ),
                        Row(
                          children: [
                            const Text('￥',style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold),),
                            Text('${info['price']}',style: const TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        )
      ) ,
    );
  }
}
