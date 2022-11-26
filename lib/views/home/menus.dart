import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cross_border_project/controller/main.dart';
import './menu_fnc.dart';

class MenusClass extends StatelessWidget {
  final imgList;
  MenusClass({super.key, required this.imgList});
  @override
  changeIcon(int index){
    // print(menusMap['${imgList[index]['info'][1]['value']}']);
    // if(imgList[index]['info'][1]['value'])
     menusMap['${imgList[index]['info'][1]['value']}']();
    // final globalStateController = Get.put(GlobalStateController());
    // globalStateController.changeBottomBarIndex(1);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.w),
        child: Container(
          // color: Colors.red,
          child: Wrap(
            spacing: 25.w,
            runSpacing:20.w,
            alignment: WrapAlignment.center,
            children: [
              for(int i=0;i<(imgList?.length??0);i++)
                GestureDetector(
                  onTap: (){
                    changeIcon(i);
                    // print('${imgList[i]['info'][1]['value']}');
                  },
                  child: Column(
                    children: [
                      Image.network('${imgList[i]['img']}',width: 90.w,height:90.h,),
                      Text('${imgList[i]['info'][0]['value']}')
                    ],
                  ),
                )
                // Text(imgList[i]['img'].toString())
            ],
            // children:[],
          ),
        ));
  }

}