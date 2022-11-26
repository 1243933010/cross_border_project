import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryContextClass extends StatefulWidget{
  var dataList=[];
  CategoryContextClass({super.key,required this.dataList});

  @override
  _CategoryContextClassState createState()=>_CategoryContextClassState();
}

class _CategoryContextClassState extends State<CategoryContextClass>{
  var chooseIndex = 0;

  getIndex(ind){
    setState(() {
      chooseIndex=ind;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.25.sw,
          height: 935.h,
          color: const Color.fromRGBO(247,247,247,1),
            // color: Colors.red,
          child: SingleChildScrollView(

            child: Column(
              children:[
                for(int i = 0;i< widget.dataList.length;i++)
                  LeftTabClass(info:widget.dataList[i],index:i,getIndex:getIndex,chooseIndex:chooseIndex)
              ]

            ),
          )
        ),
        Container(
            width: 0.75.sw,
            height: 935.h,
            // color: Colors.yellow,
          child:  Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
            child: SingleChildScrollView(
              child: RightContextClass(childrenData:widget.dataList[chooseIndex]['children']),
            ),
          )
        )
      ],
    );
  }
}

class LeftTabClass extends StatelessWidget{
  var info = {};
  var index=0;
  var bool = false;
  var getIndex;
  var chooseIndex;
  LeftTabClass({super.key,required this.info,required this.index,required this.getIndex,required this.chooseIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: index==chooseIndex?Colors.white:const Color.fromRGBO(247,247,247,1),
      child: GestureDetector(
        onTap: (){getIndex(index);},
        child: Padding(
          padding:const EdgeInsets.only(left: 5,top: 10,bottom: 10),
          child: Center(
            child: Text(
              '${info['cate_name']}',
              style: TextStyle(
                  color:index==chooseIndex?Colors.red:Colors.black,
                  fontWeight:index==chooseIndex? FontWeight.bold :FontWeight.normal),
            ),
          ),
        ),
      )
    );
  }
}


class RightContextClass extends StatelessWidget{
  var childrenData = [];

  RightContextClass({super.key,required this.childrenData});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: childrenData.map<Widget>((e)=>
         Column(
           children: [
             SizedBox(
               width: 120.w,
               height: 120.w,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(50),
                 child: Image.network('${e['pic']}'),
               ),
             ),
             Text('${e['cate_name']}')
           ],
         )
      ).toList(),
    );
  }
}