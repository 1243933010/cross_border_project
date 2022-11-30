import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputNumberClass extends StatefulWidget{
  int num;
  var handleInput;
  InputNumberClass({super.key,required this.num,required this.handleInput});
  @override
  _InputNumberClassState createState()=>_InputNumberClassState();
}

class _InputNumberClassState extends State<InputNumberClass>{

  TextEditingController _nameController = TextEditingController();
   @override
  void initState() {
    super.initState();
  }
  @override
  handleButton(increment){
    widget.handleInput(increment);
  }
  @override

  Widget build(BuildContext context) {
    _nameController.text = widget.num.toString();
    return Container(
      width: 220.w,
      height: 50.h,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){handleButton('reduce');},
            child: Container(
              width: 70.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey),
                // color: Colors.blue,
              ),
              child: const Center(
                child: Text('-',style: TextStyle(fontSize: 25),strutStyle: StrutStyle(forceStrutHeight: true,height: 1.8),),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 80.w,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _nameController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                ],
              ),
            ),
          ),
         GestureDetector(
           onTap: (){handleButton('add');},
           child:  Container(
             width: 70.w,
             decoration: BoxDecoration(
               border: Border.all(width: 1,color: Colors.grey),
               // color: Colors.blue,
             ),
             child: const Center(
               child: Text('+',style: TextStyle(fontSize: 25),strutStyle: StrutStyle(forceStrutHeight: true,height: 1.8),),
             ),
           ),
         )
        ],
      ),
    );
  }
}