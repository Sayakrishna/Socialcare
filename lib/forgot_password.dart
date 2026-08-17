import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'login.dart';
import 'main.dart';

void main() {
  runApp(const MaterialApp(
    home: forgot_password(title: 'Login'),
    debugShowCheckedModeBanner: true,

  ));
}

class forgot_password extends StatefulWidget {
  const forgot_password({super.key, required this.title});
  final String title;

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const myloginpage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF3FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top banner
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Color(0xFF45A005),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                    ),
                  ),
                  const Positioned(
                    top: 100,
                    left: 20,
                    child: Text(
                      'forgot password?',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field


                      // Forgot Password

                      const SizedBox(height: 20),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendData,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.orange[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Submit", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider

                      // Signup Buttons

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String email = _emailController.text.trim();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/android_forget_password_post/');
    try {
      final response = await http.post(urls, body: {
        'email': email,
      });
      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        String status = body['status'];
        if (status == 'ok') {


            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => myloginpage(title: '')));
            Fluttertoast.showToast(msg: 'Password sent to you mail');

        }
        else {
          _showSnackBar('Invalid email or password');
        }
      } else {
        _showSnackBar('Network Error');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
