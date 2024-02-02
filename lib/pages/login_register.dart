import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  TabController? _tabController;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

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

  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
    );
  }

  Widget _buildTextField(
      {required String hintText, required IconData icon, bool isPassword = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: isPassword ? _controllerPassword : _controllerEmail,
        decoration: _inputDecoration(hintText, icon),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login / Register'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Sign Up'),
            Tab(text: 'Sign In'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSignUp(),
          _buildSignIn(),
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        _buildTextField(hintText: 'Full Name', icon: Icons.person),
        _buildTextField(hintText: 'Email', icon: Icons.email),
        _buildTextField(
            hintText: 'Password', icon: Icons.lock, isPassword: true),
        _buildButton(text: 'Sign Up', onPressed: register),
        // Add more widgets for the rest of the sign-up form...
      ],
    );
  }

  Widget _buildSignIn() {
    bool _isRememberMeChecked = false; // You might want to manage this state at a higher level

    // Function to toggle the 'Remember me' checkbox state
    void _toggleRememberMe(bool? value) {
      setState(() {
        _isRememberMeChecked = value ?? false;
      });
      // You can also handle the logic to remember the user here
    }

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        _buildTextField(hintText: 'Email', icon: Icons.email),
        _buildTextField(
            hintText: 'Password', icon: Icons.lock, isPassword: true),
        Padding(
          padding: EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
          child: Row(
            children: [
              Checkbox(
                value: _isRememberMeChecked,
                onChanged: _toggleRememberMe,
                activeColor: Colors.blue, // Replace with your color
              ),
              Text('Remember me'),
              Spacer(),
              // Use Spacer to push the next widget to the end of the row
              GestureDetector(
                onTap: () {
                  // Handle 'Forgot Password?' tap
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue, // Replace with your color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildButton(text: 'Sign In', onPressed: signIn),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}