import 'package:get/get.dart';
import 'package:cross_border_project/views/category/category.dart';
import 'package:cross_border_project/views/login/login.dart';
import 'package:cross_border_project/views/boutique/boutique.dart';
import 'package:cross_border_project/views/homeMenus/coupon/coupon.dart';
import 'package:cross_border_project/views/article/article.dart';
import 'package:cross_border_project/views/person/orderList/orderList.dart';
import 'package:cross_border_project/views/article/article_detail/articleDetail.dart';
import 'package:cross_border_project/views/collection/collection.dart';

class RouterHelper {
  static const String categoryPage = '/category-page';
  static const String login = '/login';
  static const String boutique = '/boutique';
  static const String coupon = '/coupon';
  static const String article = '/article';
  static const String orderList = '/orderList';
  static const String articleDetail = '/articleDetail';
  static const String collection = '/collection';

  static List<GetPage> routes = [
    GetPage(name: categoryPage, page: () =>  CategoryPageClass()),
    GetPage(name: login, page: () =>  LoginClass()),
    GetPage(name: boutique, page: ()=>BoutiquePageClass()),
    GetPage(name: coupon, page: ()=>CouponPageClass()),
    GetPage(name: article, page: ()=>ArticlePageClass()),
    GetPage(name: orderList, page: ()=>OrderListClass()),
    GetPage(name: articleDetail, page: ()=>ArticleDetailClass()),
    GetPage(name: collection, page: ()=>CollectionClass()),

  ];
}