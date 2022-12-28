import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/widgets/HotRadio.dart';
class CollectionListItem extends StatefulWidget{
  Map item = {};
  bool clickShowBool;
  int index = 0;
  var changeItemRadio;
  CollectionListItem({super.key,required this.item,required this.clickShowBool,required this.index,required this.changeItemRadio});
  @override
  _CollectionListItemState createState()=>_CollectionListItemState();
}

class _CollectionListItemState extends State<CollectionListItem>{
  Color hotBorder =const Color.fromRGBO(242,242,242,1);
  Icon checkTrue = const Icon(
    IconData(
      0xf01b6,
      fontFamily: 'checkRadio',
      matchTextDirection: true,
    ),
    color: Colors.red,
    size: 31,
  );
  changeRadio(bool status){
    // print(status);
    // print(widget.index);
    widget.changeItemRadio({'index':widget.index,'status':status});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.w,
      // color: Colors.red,
      decoration: const BoxDecoration(
        // color: Colors.red,
          border: Border(
              top: BorderSide(width: 1,color: Color.fromRGBO(242,242,242,1))
              // top: BorderSide(width: 1,color: Colors.red)
          )
      ),
      child: Padding(
        padding:const EdgeInsets.only(top: 10,bottom: 10,left: 5),
        child: Row(
          children: [
          widget.clickShowBool?Padding(
               padding:const EdgeInsets.only(right: 10),
               child: HotRadioClass(radioBool:widget.item['checkBool'],changeRadio:changeRadio,hotBorder:hotBorder,checkTrue:checkTrue),
           ):const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network('${widget.item['image']}',width: 140.w,),
            ),
            Expanded(child: Padding(
              padding:const EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 550.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('${widget.item['store_name']}',overflow: TextOverflow.ellipsis,maxLines: 2,))
                      ],
                    ),
                    Text('￥${widget.item['price']}',style: const TextStyle(color: Color.fromRGBO(255,87,34,1)),)
                  ],
                ),
              ),
            ))
          ],
        ),
      )
    );
  }
}