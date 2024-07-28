import 'package:flutter/material.dart';
import 'package:no_proxy/staff_dash.dart';
import 'staffpage.dart';
import 'studentpage.dart';
import 'qr_generate.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title:'Navigation Sample',
      theme:ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:HomePage(),
      routes:{
        '/staff':(context) => StaffPage(),
        '/student':(context) => StudentPage(),
        '/staff_dash':(context) => DashboardPage(),
        '/qr_generate':(context) => QrGeneratePage()
      },
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
        appBar:AppBar(
          title:Text('NO PROXY',
          style: TextStyle(color:Colors.white),
          ),
          backgroundColor: Color(0xFF101820),
          centerTitle: true,
          
        ),
        body:Container(
          color:Colors.yellow ,
          child:Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/staff');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xFF101820),
                  ),
                  child:Text("STAFF",
                    style:TextStyle(color:Colors.yellow,
                    )
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/student');
                }, 
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF101820),
                ),
                child: Text("STUDENT",
                style:TextStyle(color:Colors.yellow,
                ), 
                ),
                )
              ],
            )
          )
        )
    );
  }
}

