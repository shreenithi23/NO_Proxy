import 'package:flutter/material.dart';
import 'staff_dash.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bcrypt/bcrypt.dart';
import 'dart:convert';

class StaffPage extends StatefulWidget {
  @override
  _staffpageState createState() => _staffpageState();
}

class _staffpageState extends State<StaffPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _supabase = Supabase.instance.client;

  Future<void> _login() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    //final hashedPassword = BCrypt.hashpw(password,BCrypt.gensalt());


    try {
      final response=await _supabase
        .from('staff')
        .select()
        .eq('email',email)
        .single();
      print(response);
      
      
      //final isPassCrt= BCrypt.checkpw(password,response['password']);
    if(response!=null){
      if(password==response['password']){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()),);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect Password')),);
      }
    } 
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found with this email')),);
    }
    
  }
  catch (error) {
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STAFF LOGIN"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          //key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
