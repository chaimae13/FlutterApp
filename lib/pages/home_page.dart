import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:proj/pages/qrcode.dart';
import 'package:proj/pages/testreport.dart';
import 'package:proj/pages/trucking.dart';
import 'package:proj/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<String> _getUDID() async {
    String udid = await FlutterUdid.udid;
    return udid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.email ?? 'User'}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Scan QR Code'),
                leading: Icon(Icons.qr_code),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRCODE()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Tracking'),
                leading: Icon(Icons.track_changes),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TRUCKING()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Test Report'),
                leading: Icon(Icons.report),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TESTREPORT()));
                },
              ),
            ),
            FutureBuilder<String>(
              future: _getUDID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    title: Text('UDID: Loading...'),
                  );
                } else if (snapshot.hasData) {
                  return ListTile(
                    title: Text('UDID: ${snapshot.data}'),
                  );
                } else {
                  return ListTile(
                    title: Text('UDID: Error'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
