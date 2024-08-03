import 'package:flutter/material.dart';
import 'package:no_proxy/qr_generate.dart';


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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>QRGeneratePage()),);
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