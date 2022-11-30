import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show Platform;

void errorInfo(info) {
  Fluttertoast.showToast(msg: info,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void successInfo(info) {
  Fluttertoast.showToast(msg: info,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showDialogFunction(context,infoObj,fnc) {
  if(infoObj['title']==null){
    infoObj['title'] = '提示';
  }
  if(infoObj['cacelText']==null){
    infoObj['cacelText'] = '取消';
  }
  if(infoObj['sureText']==null){
    infoObj['sureText'] = '确定';
  }
  if (Platform.isAndroid) {
     showGeneralDialogFunction(context, infoObj,fnc);
  } else if (Platform.isIOS) {
     iosDialog(context,infoObj,fnc);
  }
}

void showGeneralDialogFunction(context, infoObj,fnc)async {
  var status = await showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation,Animation<double> secondaryAnimation) {
      return AlertDialog(
        title: Text("${infoObj['title']}"),
        content: Text("${infoObj['label']}"),
        actions: [
          TextButton(
            onPressed: () async{
               Navigator.of(context).pop(false);
            },
            child:  Text("${infoObj['cacelText']}"),
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pop(true);
          }, child:  Text("${infoObj['sureText']}"),),
        ],
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return ScaleTransition(
        alignment: Alignment.center,
        scale: animation,
        child: child,
      );
    },
  );
  fnc(status);
}
iosDialog(context,infoObj,fnc) async{
  var status = await showCupertinoDialog(
//点击空白处取消
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("${infoObj['title']}"),
        content: Text("${infoObj['label']}"),
        actions: [
          CupertinoDialogAction(
            child:  Text("${infoObj['cacelText']}"),
            onPressed: () {
              Navigator.pop(context,false);
            },
          ),
          CupertinoDialogAction(
            child:Text("${infoObj['sureText']}"),
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
        ],
      );
    },
  );
  fnc(status);
}