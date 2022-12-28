import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// radioBool 当前是否选中
/// changeRadio 点击触发回调给父组件
/// hotBorder 当前样式
/// checkTrue 选中样式包括ttftf

class HotRadioClass extends StatefulWidget {
  bool radioBool ;
  var changeRadio;
  var hotBorder;
  var checkTrue;
  HotRadioClass({super.key, required this.radioBool, required this.changeRadio, this.hotBorder,this.checkTrue});

  @override
  _HotRadioClassState createState() => _HotRadioClassState();
}

class _HotRadioClassState extends State<HotRadioClass> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.changeRadio(!widget.radioBool);
            setState(() {
              widget.radioBool = !widget.radioBool;
            });
          },
          child: !widget.radioBool
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          color:widget.hotBorder ?? Colors.red,
                          border: widget.hotBorder!=null?Border.all(width: 1, color:widget.hotBorder):Border.all(width: 1, color: Colors.red)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          // width: 49.w,
                          // height: 49.w,
                          color: Colors.white,
                        ),
                      )),
                )
              : widget.checkTrue ?? const Icon(
                  IconData(
                    0xe626,
                    fontFamily: 'changeRadio',
                    matchTextDirection: true,
                  ),
                  color: Colors.red,
                  size: 31,
                ),
        )
      ],
    );
  }
}
