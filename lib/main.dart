import 'package:flutter/material.dart';
import 'index_page.dart';
import './provide/counter.dart';
import 'package:provide/provide.dart';
void main(){
  var counter =Counter();
  var providers =Providers();
  providers..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(
    child:MyApp() ,
    providers: providers,
  ) );
}

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
