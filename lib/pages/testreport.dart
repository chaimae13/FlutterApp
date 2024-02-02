import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class TESTREPORT extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateUserCovidStatus(BuildContext context, bool isPositive) async {
    await Firebase.initializeApp();
    final User? user = _auth.currentUser;
    if (user != null) {
      // Assuming this updates some status on the user's profile or elsewhere
      // It's better to update Firestore or Realtime Database rather than the user's display name for such purposes
      // This is a placeholder for actual update logic
      String statusUpdate = isPositive ? 'positive' : 'negative';
      // Placeholder for showing dialog
      _showAlert(context, 'COVID Status Update', 'Your COVID status has been updated to $statusUpdate.');
    }
  }

  Future<void> _showAlert(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
        title: Text('COVID Status Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _updateUserCovidStatus(context, true),
              child: Text('Report Positive'),
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateUserCovidStatus(context, false),
              child: Text('Report Negative'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
