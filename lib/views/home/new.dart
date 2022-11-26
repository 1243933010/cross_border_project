import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';


class NewsClass extends StatelessWidget{
  final Map newsObj;
  const NewsClass({super.key,required this.newsObj});
  @override
  Widget build(BuildContext context) {
    return newsObj['img'].isEmpty?Text(''): Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          width: 370,
          height: 45,
          color:const Color.fromRGBO(255,249,247,1),
          child: Padding(
            padding: const EdgeInsets.only(left: 20,),
            child: Row(
              children: [
                Image.network(newsObj['img'],width: 90),
                Padding(padding:const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 200,
                    height: 30,
                    decoration:const BoxDecoration(
                      // color: Colors.yellow,
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.black54
                        )
                      )
                    ),
                    child: Swiper(
                      autoplay:newsObj['list'].length>1?true:false,
                      scale: 1,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){print(newsObj['list'][index]);},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Expanded(child: Text('${newsObj['list']?[index]?['val']}'))
                              ],
                            ),
                          )
                        );
                      },
                      itemCount:  newsObj['list'].length,
                    ),
                  ),
                ),
               const Expanded(
                    child: Icon(Icons.keyboard_arrow_right,color: Colors.grey,)
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}