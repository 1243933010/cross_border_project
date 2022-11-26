import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchClass extends StatelessWidget{

  @override
  changeText(v){
    Fluttertoast.showToast(
        msg: "${v}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Container(
      width: 0.9.sw,
      height: 90.h,
      decoration: BoxDecoration(
        color: Color.fromRGBO(245,245,245,1),
        //   color: Colors.red,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Row(
          children: [
            Container(
              // width: 0.3.sw,
              height: 50.h,
              child: Icon(Icons.search,color: Colors.grey,),
            ),
            Container(
              // color: Colors.red,
              width: 0.78.sw,
              height: 50.h,
              child:  TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "",
                  // hintText: "用户名或邮箱",
                  // prefixIcon: Icon(Icons.search,color: Colors.grey,)
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (v)=>changeText(v),
              ),
            )
          ],
        ),
      )
    )
    );
  }
}