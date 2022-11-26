import 'package:flutter/material.dart';
import './controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenusClass extends StatelessWidget {
  final imgList;
  MenusClass({super.key, required this.imgList});

  final Controller c = Get.put(Controller());

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
                  onTap: ()=>{
                    print('${imgList[i]['info'][1]['value']}')
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
