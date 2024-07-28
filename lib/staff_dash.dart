import 'package:flutter/material.dart';


class DashboardPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(

        title:Text('NO PROXY',
        style: TextStyle(color:Colors.white),
        ),
        backgroundColor: Color(0xFF101820),
        centerTitle: true,
      ),
      body: Container(
        color:Colors.yellow,
        child: Center(
          child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/qr_generate');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF101820),
              ),
              child: Text("GENERATE QR",
              style: TextStyle(color:Colors.yellow),
              ),
          )
        ),
      ),
    );
  }
}