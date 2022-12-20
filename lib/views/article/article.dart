import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/widgets/Toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './articleTab.dart';

class ArticlePageClass extends StatefulWidget {
  ArticlePageClass({super.key});

  @override
  _ArticlePageClassState createState() => _ArticlePageClassState();
}

class _ArticlePageClassState extends State<ArticlePageClass> {
  var bannerList = [];
  var hotList = [];
  var articleList = [];

  getBannerList() {
    request('articleBannerList', 'get', null).then((val) {
      var data = jsonDecode(val.toString());
      if (data != null) {
        if (data['status'] == 200) {
          var arr = [];
          for (var i = 0; i < data['data'].length; i++) {
            for (var j = 0; j < data['data'][i]['image_input'].length; j++) {
              arr.add(data['data'][i]['image_input'][j]);
            }
          }
          setState(() {
            bannerList = arr;
          });
          return false;
        }
        errorInfo(data['msg']);
        return false;
      }
    });
  }

  getHotList() {
    request('articleHotList', 'get', null).then((val) {
      var data = jsonDecode(val.toString());
      // print(data);
      if (data != null) {
        if (data['status'] == 200) {
          setState(() {
            hotList = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
        return false;
      }
    });
  }

  getArticleList() {
    request('articleCategoryList', 'get', null).then((val) {
      var data = jsonDecode(val.toString());
      // print(data);
      if (data != null) {
        if (data['status'] == 200) {
          setState(() {
            articleList = data['data'];
          });
          return false;
        }
        errorInfo(data['msg']);
        return false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBannerList();
    getHotList();
    getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '资讯',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
            child: Center(
          child: Column(
            children: [
              Container(
                width: 700.w,
                height: 400.h,
                // color: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Swiper(
                    autoplay: true,
                    scale: 0.9,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          print(index);
                        },
                        child: Image.network(
                          bannerList[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    itemCount: bannerList.length,
                    pagination: const SwiperPagination(),
                    // control: SwiperControl(),
                  ),
                ),
              ),
              ArticleTabClass(hotList: hotList, articleList: articleList),
            ],
          ),
        )));
  }
}
