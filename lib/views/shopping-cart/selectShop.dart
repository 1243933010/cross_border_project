import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_border_project/widgets/HotRadio.dart';
import 'package:cross_border_project/widgets/inputNumber.dart';
import 'package:cross_border_project/common/network/index.dart';
import 'package:cross_border_project/widgets/Toast.dart';

class SelectShopClass extends StatelessWidget {
  var shopList;
  var changeItemFnc;
  var updateShop;
  SelectShopClass({super.key, required this.shopList,required this.changeItemFnc,required this.updateShop});

  @override
  changeItem(status,ind) {
    changeItemFnc(status,ind);
  }
  handleInput(status,ind){

    num cart_num = shopList[ind]['cart_num'];
    print(cart_num);
    if(status=='reduce'){
      cart_num=cart_num-1;
    }else{
      cart_num=cart_num+1;
    }
    request('cartNum', 'post', {'id':shopList[ind]['id'],'number':cart_num}).then((val){
      var data = jsonDecode(val.toString());
      // print('===${data}');
      if(data['status']==200){
        successInfo(data['msg']);
        updateShop();
        return false;
      }
      errorInfo(data['msg']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 900.h,
      // color: Colors.red,
      child: ListView(
        children: [
          for (var i = 0; i < shopList.length; i++)
            Container(
                width: 750.w,
                // height: 200.h,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 5,
                            color: Color.fromRGBO(245, 245, 245, 1)))),
                child: Padding(
                  padding:const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: HotRadioClass(
                            radioBool: shopList[i]['checkBool'],
                            changeRadio: (status){changeItem(status,i);}),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '${shopList[i]['productInfo']['image']}',
                          width: 120.w,
                          height: 120.w,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 10),child: SizedBox(
                          width: 450.w,
                          height: 150.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${shopList[i]['productInfo']['store_name']}',
                                    style: const TextStyle(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '属性:${shopList[i]['productInfo']['attrInfo']['suk']}',
                                    style: const TextStyle(
                                      // backgroundColor: Colors.red
                                    ),
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('￥${shopList[i]['truePrice']}'),
                                  InputNumberClass(num:shopList[i]['cart_num'],handleInput:(status){handleInput(status,i);})
                                ],
                              )
                            ],
                          )
                      ),)
                    ],
                  ),
                )),
          Container(
            height: 100.h,
          )
        ],
      ),
    );
  }
}

class AllPriceClass extends StatefulWidget{
  var shopList;
  var btnClickStatus;
  var checkAll;
  var allCheckStatus;
  var updateShop;
  AllPriceClass({super.key,required this.shopList,required this.btnClickStatus,required this.checkAll,required this.allCheckStatus,required this.updateShop});

  @override
  _AllPriceClassState createState()=>_AllPriceClassState(checkAll:checkAll);


}

class _AllPriceClassState extends State<AllPriceClass> {
  _AllPriceClassState({required this.checkAll});
  
  num allPrice = 0;
  var checkAll;
  
  @override
  cartDelFnc()async{
    var ids = getChangeId();
    request('cartDel', 'post', {'ids':ids}).then((val){
      var data = jsonDecode(val.toString());
      print(data);
      if(data['status']==200){
        successInfo(data['msg']);
        widget.updateShop();
        return false;

      }
      errorInfo(data['msg']);
    });
  }
  getChangeId(){
    var str = '';
    for(var i = 0;i<widget.shopList.length;i++){
      if(widget.shopList[i]['checkBool']){
        if(str.isEmpty){
          str = '$str${widget.shopList[i]['id']}';
        }else{
          str = '$str,${widget.shopList[i]['id']}';
        }
      }
    }
    return str;
  }
  @override
  selectAll(bool status) {
    checkAll(status);
  }
  updatePrice(){
    if(widget.shopList.length>0){
      num numPrice = 0;
      for(var i =0;i<widget.shopList.length;i++){
        if(widget.shopList[i]['cart_num']>0&&widget.shopList[i]['truePrice']>0&&widget.shopList[i]['checkBool']){
          numPrice = numPrice+(widget.shopList[i]['cart_num']*widget.shopList[i]['truePrice']);
        }
      }
      setState(() {
        allPrice = numPrice;
      });
    }
  }
  deleteItem() async{
    showDialogFunction(context, {'title':'提示','label':'是否确定删除此商品','cacelText':"取消",'sureText':'确定'},(bool status){
      print(status);
      if(status){
        cartDelFnc();
      }
    });

  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    updatePrice();
    return Container(
        width: 750.w,
        height: 110.h,
        color: const Color.fromRGBO(250, 250, 250, 1),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HotRadioClass(radioBool: widget.allCheckStatus, changeRadio: selectAll),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '全选',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
             !widget.btnClickStatus?Row(
                children: [
                   Text(
                    '￥$allPrice',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 5, bottom: 5),
                            backgroundColor:
                                const Color.fromRGBO(254, 92, 45, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {},
                        child: const Text('立即下单')),
                  )
                ],
              ): ElevatedButton(
               style: ButtonStyle(
                 side: MaterialStateProperty.all(const BorderSide(width: 1,color: Colors.grey)),
                 backgroundColor: MaterialStateProperty.all(Colors.white),
                 shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
               ),
                 onPressed: deleteItem,
                 child: const Text('刪除',style: TextStyle(color: Colors.grey),))
            ],
          ),
        ));
  }
}
