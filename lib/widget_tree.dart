import 'package:flutter/widgets.dart';
import 'package:proj/auth.dart';
import 'package:proj/pages/home_page.dart';
import 'package:proj/pages/login_register.dart';
import 'package:proj/pages/udid.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree ({Key? key}): super(key: key);

@override
State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
}
},
); // StreamBuilder
}
}