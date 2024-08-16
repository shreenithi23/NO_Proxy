import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_proxy/staff_dash.dart';
import 'staffpage.dart';
import 'studentpage.dart';
import 'qr_generate.dart';
import 'qr_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://lexqzvkyuvvqkfxhmjmi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxleHF6dmt5dXZ2cWtmeGhtam1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI2MTgyNzUsImV4cCI6MjAzODE5NDI3NX0.dEtSzHaVGyzL6uOH_FdBai44LUbmiUWhxQbZyW14cSE',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Navigation Sample',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
      routes: {
        '/staff': (context) => StaffPage(),
        '/student': (context) => StudentPage(),
        '/staff_dash': (context) => DashboardPage(),
        //'/qr_generate': (context) => QrGeneratePage(),
        '/qr_scan': (context) => QrscannerPage(),
        //'/qr_scan_result': (context) => ResultScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'NO PROXY',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF101820),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color:Color(0xffd6e2ea),
          // gradient: LinearGradient(
          //   colors: [Colors.blue.withOpacity(0.5), Colors.grey.withOpacity(0.2)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
            child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset('assets/teacher.png',
                      width:100,
                        height:100,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/staff');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(130,50),
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadowColor: Colors.black,
                          elevation: 5,
                        ),

                        child: Text(
                          "STAFF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 25,
                        width: 250,
                      ),
                      Image.asset('assets/student3.png',
                        width:180,
                        height:120,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/student');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150,50),
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadowColor: Colors.black,
                          elevation: 5,
                        ),

                        child: Text(
                          "STUDENT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
            ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    // Navigate to sign-up page
                  },
                  child: Text(
                    "No account? SIGN UP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            //Spacer(),

          ),

        ),
      ),
    );
  }
}
