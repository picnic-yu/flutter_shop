import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
class MemberPage extends StatelessWidget {
  final Widget child;

  MemberPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Number(),
            MyButton()
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(
        builder: (context,child,counter){
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}
class MyButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Provide.value<Counter>(context).increment();
        },
        child: Text('+'),
      ),
    );
  }
}