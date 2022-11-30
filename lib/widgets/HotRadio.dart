import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotRadioClass extends StatefulWidget {
  var radioBool ;
  var changeRadio;

  HotRadioClass({super.key, required this.radioBool, required this.changeRadio});

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
                          color: Colors.red,
                          border: Border.all(width: 1, color: Colors.red)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          // width: 49.w,
                          // height: 49.w,
                          color: Colors.white,
                        ),
                      )),
                )
              : const Icon(
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
