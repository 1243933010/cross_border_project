import 'package:flutter/material.dart';
import './info.dart';
import './order.dart';
import './userMenu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonPageClass extends StatefulWidget{

  PersonPageClass({super.key});
  _PersonPageClassState createState()=>_PersonPageClassState();
}

class _PersonPageClassState extends State<PersonPageClass> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('个人中心'),
        backgroundColor: const Color.fromRGBO(254,92,45,1),
        // surfaceTintColor: Colors.yellow,

      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245,245,245,1),
        // color: Colors.red
        ),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 500.h,
                  // color: Colors.orange,
                  child: Stack(
                    children: [
                      InfoClass(),
                      OrderClass(),
                    ],
                  ),
                ),
                UserMenuClass()
              ],
            )
        ),
      )
    );
  }
}