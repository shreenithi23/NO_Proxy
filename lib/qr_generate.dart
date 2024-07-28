import 'package:flutter/material.dart';
import 'staffpage.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratePage extends StatelessWidget {
  //QrGeneratePage({super.key});

  String sessionID = "session_id";

  @override
  Widget build(BuildContext context){
    //String sessionID = "session_id";
    return Scaffold(
      appBar: AppBar(

        title:Text('NO PROXY',
          style: TextStyle(color:Colors.white),
        ),
        backgroundColor: Color(0xFF101820),
        centerTitle: true,
      ),

      body: Center(
        //child:Text(sessionID),
        child:QrImageView(
          data:sessionID,
          //version: QrVersions.auto,
          size: 200.0,
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(
              100,
              100,
            ),
          ),
          //gapless: false,
        ),
      ),
    );
  }
}

//

// class QrGeneratePage extends StatefulWidget {
//   @override
//   _QrGenerateState createState() => _QrGenerateState();
// }
//
// class _QrGenerateState extends State <QrGeneratePage>{
//
//   String scanResult="";
//
//
//   Future<void> scanQrAndCheck() async{
//     String res="";
//     try{
//       res = await FlutterBarcodeScanner.scanBarcode("#ffffff", "Cancel", false, ScanMode.QR);
//     }catch(e){
//       print("error");
//     }
//   }

