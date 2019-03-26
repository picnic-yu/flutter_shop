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

import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  @override
  bool get wantKeepAlive =>true;
  int page = 1;
  List<Map> hotGoodsList = [];
  void initState() { 
    super.initState();
    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon':'115.02932','lat':'35.76189'};
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
          // FutureBuilder Widget这是一个Flutter内置的组件，是用来等待异步请求的
        future:request('homePageContext',formData:formData),
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
              return EasyRefresh(
                loadMore: ()async{
                  print('load more====================================>');
                  _getHotGoods();
                },
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载',
                ),
                child:ListView(
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
                    Container(
                      child:_hotGoods(),
                    )
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

  // 获取火爆商品方法
  void _getHotGoods(){
    var formPage={'page': page};
    request('homePageBelowConten',formData:formPage).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodList);
        page++;
      });
    });
  }
  // 火爆标题
  Widget _hotTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: Text('火爆专区'),
    ); 
  }

  // 火爆专区子项
  Widget _wrapList(){
    if(hotGoodsList.length != 0){
      List<Widget> listWidget =hotGoodsList.map((val){
        return InkWell(
          onTap: (){

          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width:ScreenUtil().setWidth(375)
                ),
                Text(
                  val['name'],
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,
                  style:TextStyle(
                    color:Colors.pink,
                    fontSize:ScreenUtil().setSp(26),
                  )
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing:2,
        children:listWidget,
      );
    }else{
      return Text('');
    }
  }
  // 火爆专区组合
  Widget _hotGoods(){
    return Container(
      child:Column(
        children: <Widget>[
          _hotTitle(),
          _wrapList(),
        ],
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


