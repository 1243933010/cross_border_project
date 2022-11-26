import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainState{
  RxInt bottombar_index = 0.obs;
  RxMap userInfo = {}.obs;
  RxBool loginBool = false.obs;
  RxString token = '123'.obs;
}