import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String errorMessage = '';

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  Widget _emailField() {
    return TextField(
      controller: _controllerEmail,
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _controllerPassword,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _emailField(),
            _passwordField(),
            if (errorMessage.isNotEmpty) Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(errorMessage, style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: signIn,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: register,
              child: Text('Register instead'),
            ),
          ],
        ),
      ),
    );
  }
}
