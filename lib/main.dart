import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/routes/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/widgets/bottomNv.dart';
import 'package:cross_border_project/controller/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  testChangeToken();
  debugDefaultTargetPlatformOverride=TargetPlatform.iOS;  //操作风格类似ios
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('test');
    return  ScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child){
          return GetMaterialApp(
            navigatorKey: Get.key,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            // debugShowMaterialGrid: true,
            // showPerformanceOverlay: true,
            title: 'Flutter Demo1',
            theme: ThemeData(
              primaryColor: Colors.white,
              primarySwatch: Colors.blue,
              highlightColor: Color.fromRGBO(0, 0, 0, 0),
              splashColor: Color.fromRGBO(0, 0, 0, 0),
              // initialRoute: RouteManager.splashPage,
              // getPages: AppPages.getPages(),
            ),
            initialRoute: '/',
            getPages: RouterHelper.routes,
            // home: const MyHomePage(),
            home: BottomNvClass(),

          );
        }
    );
  }
}


void testChangeToken()async{
  final globalStateController = Get.put(GlobalStateController());
  var token = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwd2QiOiJkNDFkOGNkOThmMDBiMjA0ZTk4MDA5OThlY2Y4NDI3ZSIsImlzcyI6InNpdC56eWpzbC5jb20iLCJhdWQiOiJzaXQuenlqc2wuY29tIiwiaWF0IjoxNjY5NDQ1MjkwLCJuYmYiOjE2Njk0NDUyOTAsImV4cCI6MTY3MjAzNzI5MCwianRpIjp7ImlkIjo3LCJ0eXBlIjoicm91dGluZSJ9fQ.RAFF-q261C4-9OR6Sx7ipdgcLG2-CW4v0CVGHi6cg3Q';
  globalStateController.changeToken(token);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  //上面是临时测试存入token,下面是每次进入都会读取存储
  final userInfo = prefs.getString('userInfo');
  if(userInfo != null){
    globalStateController.setLoginBool(true);
  }
}


