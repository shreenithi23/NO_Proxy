import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_result.dart';
class QrscannerPage extends StatelessWidget {
  QrscannerPage ({super.key});

  final MobileScannerController controller = MobileScannerController();
  bool isScanCompleted = false;
  String? qr_value;
  //String qr_valuee;
  void closeScreen(){
    isScanCompleted=false;
  }
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
      body: Container(
        child:Column(
          children:[
            Expanded(
              child: Container(
                child:Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text("Place the QR code in that area",
                    style: TextStyle(
                      color:Colors.black87,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Scanning will be done automatically",
                      style: TextStyle(
                        color:Colors.black45,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      )
                    ),

                  ],
                ),
            ),
          ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                controller: controller,
                onDetect: (BarcodeCapture capture){
                  if(!isScanCompleted){
                    final List<Barcode> barcodes = capture.barcodes;
                   // String code = capture.rawValue ?? '---';
                    for (final barcode in barcodes){
                      qr_value = barcode.rawValue;
                      //qr_value=;
                      //qr_valuee = qr_value ?? '';
                    }

                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardPage()),

                      isScanCompleted=true;
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResultScreen(
                        closeScreen: closeScreen,
                        qr_result: qr_value),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(

              child: Container(
                child:Column(
                  children: [
                    SizedBox(
                      height:60,
                    ),
                    Text(
                        "developed by NO_PROXY"
                    ),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
