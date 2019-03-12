import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primaryColor: Colors.pink//控制整个app顶部appbar颜色
      ),
      home:IndexPage()
    );
  }
}
class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body:Center(
        child: Text('百姓生活+'),
      )
    );
  }
}