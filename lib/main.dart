import 'package:flutter/material.dart';
import 'index_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner:false,//debug图标隐藏
      theme: ThemeData(
        primaryColor: Colors.pink//控制整个app顶部appbar颜色
      ),
      home:IndexPage()
    );
  }
}
