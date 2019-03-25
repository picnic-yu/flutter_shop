import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/top_navigator.dart';
import '../widgets/ad_banner.dart';
import '../widgets/leader_phone.dart';
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
          // FutureBuilder Widget这是一个Flutter内置的组件，是用来等待异步请求的
        future:getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
              var data=json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
              List<Map> navigatorList = (data['data']['category'] as List).cast();//类别列表
              if(navigatorList.length>10){
                navigatorList.removeRange(10, navigatorList.length);
              }
              String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];//广告图片
              String leaderImage = data['data']['shopInfo']['leaderImage'];//
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                  TopNavigator(navigatorList: navigatorList),//商品分类
                  AdBanner(advertesPicture:advertesPicture),//广告图片
                  LeaderPhone(leaderImage:leaderImage,leaderPhone:leaderPhone),
                ],
              );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      )
    );
  }
}
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        // pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}