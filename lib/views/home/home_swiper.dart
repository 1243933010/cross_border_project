import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './search.dart';
import './controller.dart';
import 'package:get/get.dart';

class HomeSwiper extends StatefulWidget {
  const HomeSwiper({super.key});
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    // Future.delayed(Duration(seconds: 5),()=>{  //验证数据是否实时响应刷新
    //   print('111'),
    //   c.swipterList=[]
    // });
    return Center(  child: Container(
          width: double.infinity,
          height: 530.h,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 232.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('imgs/back_png.png'),
                )),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: SearchClass(),
                ),
              ),
              Positioned(
                  width: 700.w,
                  height: 400.h,
                  top: 0.15.sw,
                  left: 0.035.sw,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Swiper(
                      autoplay:true,
                      scale: 0.9,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(()=>GestureDetector(
                          onTap: (){
                            print(index);
                            Get.toNamed('/boutique',arguments: {'id':'1'});
                          },
                          child: Image.network(
                            c.swipterList[index]["url"],
                            fit: BoxFit.fill,
                          ),)
                        );
                      },
                      itemCount:  c.swipterList.length,
                      pagination: const SwiperPagination(),
                      // control: SwiperControl(),
                    ),
                  )
              )
            ],
          )),
    );
  }
}
