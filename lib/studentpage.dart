import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class StudentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("STUDENT LOGIN"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child:Form(
          //key:_formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),)
      ),
    );
  }
}