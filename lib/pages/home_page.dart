import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/top_navigator.dart';
import '../widgets/ad_banner.dart';
import '../widgets/leader_phone.dart';
import '../widgets/recommend.dart';
import '../widgets/floor_content.dart';
import '../widgets/floor_title.dart';
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
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
              List<Map> recommendList =  (data['data']['recommend'] as List).cast(); //商品推荐
              String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
              List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
              List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片 
              return SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                    TopNavigator(navigatorList: navigatorList),//商品分类
                    AdBanner(advertesPicture:advertesPicture),//广告图片
                    LeaderPhone(leaderImage:leaderImage,leaderPhone:leaderPhone),
                    Recommend(recommendList:recommendList),
                    FloorTitle(picture_address:floor1Title),
                    FloorContent(floorGoodsList:floor1),
                    FloorTitle(picture_address:floor2Title),
                    FloorContent(floorGoodsList:floor2),
                    FloorTitle(picture_address:floor3Title),
                    FloorContent(floorGoodsList:floor3),
                  ],
                )
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