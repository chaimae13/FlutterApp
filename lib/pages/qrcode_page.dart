import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:proj/pages/nextpage.dart';

class QRCODE extends StatelessWidget {
  Future<void> scanQR(BuildContext context) async {
    try {
      var qrResult = await BarcodeScanner.scan();
      String qrText = qrResult.rawContent.isNotEmpty ? qrResult.rawContent : 'No data scanned';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPage(data: qrText)),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        _showErrorDialog(context, 'Camera access was denied');
      } else {
        _showErrorDialog(context, 'Unknown error occurred');
      }
    } on FormatException {
      // Optionally handle the user backing out of the scanner.
    } catch (e) {
      _showErrorDialog(context, 'Unknown error occurred');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Change app bar color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => scanQR(context),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              primary: Colors.green, // Change button color
            ),
            child: Text('Scan QR Code', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
