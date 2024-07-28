import 'package:flutter/material.dart';
import 'staff_dash.dart';


class StaffPage extends StatefulWidget{
  @override
  _staffpageState createState()=> _staffpageState();
}

class _staffpageState extends State<StaffPage>{
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  void login(){
    final String username=_usernameController.text;
    final String password = _passwordController.text;

    if(username=='admin' && password=='pass'){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardPage()),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid username or password")),
      );
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title:Text("STAFF LOGIN"),
          backgroundColor: Colors.white,
          centerTitle: true,
          ),
          body:Container(
            padding:EdgeInsets.all(16.0),
            child:Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true, 
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      login();
                    }
                  },
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                   child: Text(
                    'Login', 
                    style:TextStyle(color: Colors.white),
                   ),
                  ),
                ],
              ),
            ),
          ),
        );
    
}
}