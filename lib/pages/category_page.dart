import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../provide/child_category.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('商品分类')),
      body:Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryBav(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RightCategoryBav extends StatefulWidget {
  
  _RightCategoryBavState createState() => _RightCategoryBavState();
}

class _RightCategoryBavState extends State<RightCategoryBav> {
  List list = ['名酒','宝丰','北京二锅头','宝丰','北京二锅头','宝丰','北京二锅头'];
  Widget _rightInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style:TextStyle(fontSize:ScreenUtil().setSp(26))
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Provide<ChildCategory>(
        builder: (context,child,childCategory){
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.black12
                )
              )
            ),
            child: ListView.builder(
              itemCount: childCategory.childCategoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                print(childCategory.childCategoryList);
                return _rightInkWell(childCategory.childCategoryList[index]);
              },
            ),
          );
        },
      )
    );
  }
}

// 左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  @override
  void initState() { 
    super.initState();
    _getCategory();
  }
  void _getCategory() async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryBigListModel category =CategoryBigListModel.formJson(data['data']);
      setState(() {
       list = category.data; 
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }
  // 左侧导航子项
  Widget _leftInkWell(int index){
    return InkWell(
      onTap: (){
        var childList = list[index].bxMallSubDto;
        print(childList);
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0,top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12
            )
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(
          fontSize: ScreenUtil().setSp(26)
        ),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0,color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }
}


