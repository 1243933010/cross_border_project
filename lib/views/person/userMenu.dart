import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/controller/main.dart';
import 'package:cross_border_project/common/network/index.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMenuClass extends StatefulWidget {
  UserMenuClass({super.key});
  _UserMenuClassState createState()=>_UserMenuClassState();
}

class _UserMenuClassState extends State<UserMenuClass>{
  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;
  // var box = GetStorage();
  Map dataMap = {
    'routine_my_menus':[]
  };

  @override
  getMenus(){
    request('userMenu', 'get', null).then((val){
      var result = jsonDecode(val.toString());
      if(result['status']==200){
        setState(() {
          dataMap = result['data'];
        });
      }
    });
  }
  changeRequestStatus() async{
    final prefs = await SharedPreferences.getInstance();
    final bool? loginBool =  prefs.getBool('loginBool');
    if(loginBool==true){
      getMenus();
    }
  }
  @override
  void initState() {
    super.initState();
    changeRequestStatus();
    mainState.loginBool.listen((bool p0) {
      if(p0){
        getMenus();
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
          color: Colors.white,
          width: 680.w,
          child: Padding(
            padding:const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Padding(padding: EdgeInsets.only(bottom: 20),child: Text('我的服务',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                  ),
                  children: dataMap['routine_my_menus'].map<Widget>((val){
                    return Column(
                      children: [
                        Image.network('${val['pic']}',width: 70.w,height: 70.w,),
                        Text('${val['name']}')
                      ],
                    );
                  }).toList()
                  // children: [],
                ),
              ],
            ),
          )
      ),
    );
  }
}