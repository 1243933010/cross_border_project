import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadRecordClass extends StatelessWidget{
  var width = 100.w;
  @override
  LoadRecordClass({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      // color: Colors.red,
      child: Align(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
        ),
      )
    );
  }
}