import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
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
  var animationLink = 'assets/login.riv';
  SMITrigger? trigFail, trigSuccess;
  SMIBool? isChecking, isHandsUp;
  SMINumber? numLook;
  Artboard? artBoard;
  StateMachineController? stateMachineController;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final TextEditingController _nameController = TextEditingController();

  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    initArtboard();
  }

  initArtboard() async {
    final data = await rootBundle.load(animationLink);
    final file = RiveFile.import(data);
    final art = file.mainArtboard;
    stateMachineController =
        StateMachineController.fromArtboard(art, "Login Machine");
    if (stateMachineController != null) {
      art.addController(stateMachineController!);
      // Initialize the animation triggers and booleans
      trigFail = stateMachineController!.findSMI("trigFail") as SMITrigger;
      trigSuccess = stateMachineController!.findSMI("trigSuccess") as SMITrigger;
      isChecking = stateMachineController!.findSMI("isChecking") as SMIBool;
      isHandsUp = stateMachineController!.findSMI("isHandsUp") as SMIBool;
      numLook = stateMachineController!.findSMI("numLook") as SMINumber;
    }
    setState(() {
      artBoard = art;
    });
  }

  resetState() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    numLook?.change(0);
  }

  checking() {
    isChecking!.change(true);
    isHandsUp!.change(false);
    numLook!.change(0);
  }

  moveEyes(String value) {
    try {
      double numValue = double.parse(value);
      numLook!.change(numValue);
    } catch (e) {
      numLook!.change(0); // Set to a default value if conversion fails
    }
  }

  handsUp() {
    isChecking!.change(false);
    isHandsUp!.change(true);
  }

    Future<void> _login() async {
    //final name = _nameController.text;
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful')),
        );
        await Future.delayed(Duration(seconds: 3));

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()),);
      }
      else{
        trigFail!.fire();
        await Future.delayed(Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect Password')),);
      }
    } 
    // else{
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found with this email')),);
    // }
    
  }
  catch (error) {
    trigSuccess=null;
    if (trigFail != null) {
      trigFail!.fire();
      print("trigFail fired");
    }
    else {
      trigFail!.fire();
      trigFail!.fire();
    }
    await Future.delayed(Duration(seconds: 1));
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user found with this email" )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd6e2ea),
      appBar: AppBar(
        title: Text("STAFF LOGIN"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Container(
          //key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (artBoard != null)
                SizedBox(
                  width: 350,
                  height: 300,
                  child: Rive(
                    artboard: artBoard!,
                  ),
                ),
              // TextFormField(
              //   controller: _nameController,
              //   decoration: InputDecoration(labelText: 'Name'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter name';
              //     }
              //     return null;
              //   },
              // ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
              TextFormField(
                onTap: checking,
                onChanged: (value) => moveEyes(value),
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
                onTap: handsUp,
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
                  backgroundColor: Color(0xffd6e2ea),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ],
          ),
          ),
          ],
      ),
        ),
      ),
      ),
    );
  }
}
