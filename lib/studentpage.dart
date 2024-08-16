import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'qr_scanner.dart';

import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  var animationLink = 'assets/login.riv';
  SMITrigger? trigFail, trigSuccess;
  SMIBool? isChecking, isHandsUp;
  SMINumber? numLook;
  Artboard? artBoard;
  StateMachineController? stateMachineController;

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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    resetState();

    try {
      final response = await _supabase
          .from('students')
          .select()
          .eq('email', username)
          .single();
      print(response);

      if (response != null) {
        if (password == response['password']) {
          //trigSuccess!.fire();
          //trigSuccess = null;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Successful')),
          );

          await Future.delayed(Duration(seconds: 3));
          print("Navigating to QR Scanner Page"); // Debugging print
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => QrscannerPage()),
          );
        } else {
          trigFail!.fire();
          await Future.delayed(Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect Password')),
          );
        }
      }
      //  else {
      //   trigFail!.fire();
      //   await Future.delayed(Duration(seconds: 1));
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('1No user found with this email')),
      //   );
      // }
    } catch (error) {
      //trigSuccess=false as SMITrigger?;
      //trigFail=false as SMITrigger;
      //trigFail=null;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user found with this email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd6e2ea),
      appBar: AppBar(
        title: Text("STUDENT LOGIN"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                if (artBoard != null)
                  SizedBox(
                    width: 350,
                    height: 300,
                    child: Rive(
                      artboard: artBoard!,
                    ),
                  ),
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
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        onTap: handsUp,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
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
