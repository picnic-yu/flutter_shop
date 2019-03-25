// 店长拨打电话组件
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);

  void _launchURL() async{
    String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      print('手机不可用');
      throw '手机不可用';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }
}