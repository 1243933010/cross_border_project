# cross_border_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### fonts文件放的是ttf文件
### l10n未使用
###  icons未使用
### imgs存放图片
### json未使用

### lib存放业务逻辑
- common存放公共函数
> **network处理request请求以及对dio的封装**

> **controller处理getx相应数据的修改函数**

> **routes集中处理路由注册**
> **states存放getx动态相应数据**

> **views存放所有页面**
- addressClient 地址管理
- article 行业咨询列表以及详情页
- boutique 精品推荐页
- category文件夹分类页
- collection 我的收藏页面
- home文件夹首页
- login 登陆页
- person 个人中心页
- shopping-cart 购物车页

> **widgets存放公平组件或者公共封装函数**
- bottomNv 对首页tab进行的封装,实现body动态切换
- HotRadio 封装一个单选框
- inputNumber 封装一个数字加减框
- Toast 封装一个弹出提示框