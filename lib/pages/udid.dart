import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

class UDIDScreen extends StatefulWidget {
  @override
  _UDIDScreenState createState() => _UDIDScreenState();
}

class _UDIDScreenState extends State<UDIDScreen> {
  String _udid = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getDeviceUDID();
  }

  Future<void> _getDeviceUDID() async {
    String udid = await FlutterUdid.udid;
    setState(() {
      _udid = udid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDID'),
      ),
      body: Center(
        child: Text('UDID: $_udid'),
      ),
    );
  }
}
