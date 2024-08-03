import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class QRGeneratePage extends StatefulWidget {
  @override
  _QRGeneratePageState createState() => _QRGeneratePageState();
}

class _QRGeneratePageState extends State<QRGeneratePage> {
  final TextEditingController _courseIDController = TextEditingController();
  String? qrData;

  void _generateQR() {
    String courseID = _courseIDController.text.trim();
    if (courseID.isNotEmpty) {
      String timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
      setState(() {
        qrData = '$courseID|$timestamp';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid course ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NO Proxy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF101820),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _courseIDController,
              decoration: InputDecoration(
                labelText: 'Enter course ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Add some spacing between the input and button
            ElevatedButton(
              onPressed: _generateQR,
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 20), // Add some spacing between the button and QR code
            if (qrData != null)
              QrImageView(
                data: qrData!,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}

// class QrGeneratePage extends StatelessWidget {
//   //QrGeneratePage({super.key});

//   final String courseID;

//   QrGeneratePage({required this.courseID});

//   @override
//   Widget build(BuildContext context){
//     //String sessionID = "session_id";
    
//     return Scaffold(
//       appBar: AppBar(

//         title:Text('NO PROXY',
//           style: TextStyle(color:Colors.white),
//         ),
//         backgroundColor: Color(0xFF101820),
//         centerTitle: true,
//       ),

//       body: Center(
//         //child:Text(sessionID),
//         child:QrImageView(
//           data:sessionID,
//           //version: QrVersions.auto,
//           size: 200.0,
//           embeddedImageStyle: QrEmbeddedImageStyle(
//             size: const Size(
//               100,
//               100,
//             ),
//           ),
//           //gapless: false,
//         ),
//       ),
//     );
//   }
// }


// // class QrGeneratePage extends StatefulWidget{
// //   //final int courseid;
  
// //   //QrGeneratePage({required this.courseid});

// //   @override
// //   _GenerateQRCodePageState createState()=> _GenerateQRCodePageState();
// // }

// // class _GenerateQRCodePageState extends State<QrGeneratePage>{
// //   final _supabase=Supabase.instance.client;
// //   String? _qrdata;
// //   @override
// //   void initState(){
// //     super.initState();
// //     _generateqr();
// //   }

// //   Future<void>_generateqr() async{
// //     final courseId=widget.courseid;
// //     final response=await _supabase
// //       .from('courses')
// //       .select('staff_id')
// //       .eq('course_id',courseId)
// //       .single();
// //     //String? qrdata;
// //     if(response!=null){
// //       final staffid=response['staff_id'];
// //       final qrdata=jsonEncode({
// //         'course_id':courseId,
// //         'staff_id':staffid,
// //       });

// //       setState(() {
// //       _qrdata= qrdata;
// //     });
// //     }
// //     else{
// //       print('Course not found/Error Occured');
// //     }
    
// //   }

// //   @override 
// //   Widget build(BuildContext context){
// //     return Scaffold(
// //       appBar: AppBar(
// //         title:Text('Generating QR code'), 
// //       ),
// //       body:Center(
// //         child: _qrdata==null?CircularProgressIndicator():QrImageView(data: _qrdata!,version: QrVersions.auto,size:200.0,),
// //       ),
// //     );
// //   }
// // }