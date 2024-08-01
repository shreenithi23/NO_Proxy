import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_scanner.dart';

class ResultScreen extends StatelessWidget {
  final String? qr_result;
  final Function() closeScreen;
  const ResultScreen({super.key, required this.closeScreen, required this.qr_result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("QR Scanner",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Text(qr_result!,
                style: TextStyle(
                  color:Colors.black87,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
            ),
            SizedBox(
              height:10,
            ),
          ],
        ),
      ),
    );
  }
}
