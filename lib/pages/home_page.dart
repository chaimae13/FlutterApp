import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:proj/pages/qrcode_page.dart';
import 'package:proj/pages/covid_page.dart';
import 'package:proj/pages/nearby.dart';
import 'package:proj/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final User? user = Auth().currentUser;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pop(context); // Pop the home page after signing out
  }

  Future<String> _getUDID() async {
    String udid = await FlutterUdid.udid;
    return udid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${user?.email ?? 'User'}', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => signOut(context),
          ),
        ],
        backgroundColor: Colors.blue, // Change app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              color: Colors.grey, // Change card color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text('UDID', style: TextStyle(color: Colors.white)),
                subtitle: FutureBuilder<String>(
                  future: _getUDID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...', style: TextStyle(color: Colors.white));
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data!, style: TextStyle(color: Colors.white));
                    } else {
                      return Text('Error', style: TextStyle(color: Colors.white));
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: Card(
                color: Colors.orange, // Change card color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text('Scan QR Code', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.qr_code, color: Colors.white),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QRCODE()));
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: Card(
                color: Colors.green, // Change card color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text('Tracking', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.track_changes, color: Colors.white),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TRACKING()));
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: Card(
                color: Colors.red, // Change card color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text('Test Report', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.report, color: Colors.white),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TESTREPORT()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
