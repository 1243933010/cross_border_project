import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoClass extends StatefulWidget{
  InfoClass({super.key});
  _InfoClassState createState()=>_InfoClassState();
}

class _InfoClassState extends State<InfoClass>{
  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;
  var userInfo = {
  };
  var loginStatus = false;

  @override
  goLogin()async{
    if(mainState.loginBool.isFalse){
       Get.toNamed('/login');
    }
  }
 getUserInfo()async{
   final prefs = await SharedPreferences.getInstance();
   final bool? loginBool =  prefs.getBool('loginBool');
   var userInfoStr =  prefs.getString('userInfo');
   // prefs.clear();

   if(userInfoStr != null&& loginBool!= null){
     setState(() {
       userInfo = json.decode(userInfoStr);
       loginStatus = loginBool;
     });
     print(loginBool);
     print(userInfoStr);
     // print(userInfo['avatar']);
   }

 }
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration:const BoxDecoration(
        color: Color.fromRGBO(254,92,45,1),
        image: DecorationImage(
          image: AssetImage('imgs/user01.png'),
          fit: BoxFit.fitWidth
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column (
          // alignment: Alignment.center,
          children:<Widget> [
            UserInfoClass(goLogin:goLogin,userInfo:userInfo,loginStatus:loginStatus),
            Padding(padding: const EdgeInsets.only(top: 10),child: EquityClass(),),

          ],
        )
      ),
    );
  }
}

//用户头像
class UserInfoClass extends StatelessWidget{
  var goLogin;
  var userInfo;
  var loginStatus;
  UserInfoClass({super.key,required this.goLogin,required this.userInfo,required this.loginStatus});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){},
          child: Row(
            children: [
              GestureDetector(
                onTap:(){
                  goLogin();
                },
                child: Row(
                  children: [
                     ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: loginStatus?  FadeInImage(
                          width: 110.w,
                          height: 110.h,
                          placeholder: const AssetImage('imgs/back_png.png'),
                          image: NetworkImage('${userInfo['avatar']}')
                      ):Image.asset('imgs/f.png',width: 110.w,height: 110.h,)
                    ),
                      Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: loginStatus?Text('${userInfo['real_name']}',style:const TextStyle(color: Colors.white)):const Text('请登录',style: TextStyle(color: Colors.white),),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        const Expanded(child: Text('')),
        Row(
          children: const [
            Icon(Icons.settings,color: Colors.white,size: 22,),
            Icon(Icons.add_alert_sharp,color: Colors.white,size: 22,)
          ],
        )
      ],
    );
  }
}


//收藏
class EquityClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 20.w,right: 20.w),child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('0',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            Text('收藏',style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
        ),
        Padding(padding: const EdgeInsets.only(top: 2),child: Container(
          height: 35.h,
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(
                      width: 1,
                      color: Colors.white
                  )
              )
          ),
        ),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('0',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            Text('优惠券',style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
          height: 35.h,
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(
                      width: 1,
                      color: Colors.white
                  )
              )
          ),
        ),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Text('0',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            Text('积分',style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
        )
      ],
    ),
    );
  }
}