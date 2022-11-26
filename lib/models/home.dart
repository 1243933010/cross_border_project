
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cross_border_project/common/network/index.dart';

class HomeFncClass  {
  @override
  getRecommendList(Map obj) {
    Map<String, dynamic> params = {
      'page': 1,
      'limit': 10,
      'type': obj['selectSortConfig']['activeValue'],
      'selectType': obj['tabConfig']['tabVal']
    };
    if (obj['tabConfig']['tabVal'] == 0) {
      params['newsOrder'] = obj['goodsSort']['type'] == 2 ? 'news' : '';
      params['salesOrder'] = obj['goodsSort']['type'] == 1 ? 'desc' : '';
      params['selectId'] = obj['selectConfig']['activeValue'] ?? '';
    } else {
      params['ids'] = obj['ids'];
    }
    return request('getHomeProducts', 'get', params);
  }

}