import 'package:get/get.dart';
import 'package:cross_border_project/views/category/category.dart';
import 'package:cross_border_project/views/login/login.dart';


class RouterHelper {
  static const String categoryPage = '/category-page';
  static const String login = '/login';


  static List<GetPage> routes = [
    GetPage(name: categoryPage, page: () =>  CategoryPageClass()),
    GetPage(name: login, page: () =>  LoginClass()),
  ];
}