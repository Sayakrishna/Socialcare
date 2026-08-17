// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../login.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const vchangepass(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class vchangepass extends StatefulWidget {
//   const vchangepass({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<vchangepass> createState() => _vchangepassState();
// }
//
// class _vchangepassState extends State<vchangepass> {
//   TextEditingController oldpasswordcontroller = TextEditingController();
//   TextEditingController newpasswordcontroller = TextEditingController();
//   TextEditingController confirmpasswordcontroller = TextEditingController();
//
//
//   void _send_data() async {
//     String currentpassword = oldpasswordcontroller.text;
//     String newpassword = newpasswordcontroller.text;
//     String confirmpassword = confirmpasswordcontroller.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid= sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/uservchangepass/');
//     try {
//       final response = await http.post(urls, body: {
//         'currentpassword': currentpassword,
//         'newpassword': newpassword,
//         'confirmpassword': confirmpassword,
//         'lid':lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => myloginpage(title: '',)),
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: oldpasswordcontroller,
//               decoration: InputDecoration(labelText: 'oldpassword',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             TextFormField(
//               controller: newpasswordcontroller,
//               decoration: InputDecoration(labelText: 'newpassword',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             TextFormField(
//               controller: confirmpasswordcontroller,
//               decoration: InputDecoration(labelText: 'confirmpassword',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text('save')),
//           ],
//         ),
//       ),
//
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../login.dart';
import 'volunteerhome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Password',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD7C0AE),
          primary: const Color(0xFFB7A99A),
          secondary: const Color(0xFFEAD7C3),
          tertiary: const Color(0xFF967E76),
          background: const Color(0xFFF9F5F0),
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const vchangepass(title: 'Change Password'),
    );
  }
}

class vchangepass extends StatefulWidget {
  const vchangepass({super.key, required this.title});

  final String title;

  @override
  State<vchangepass> createState() => _vchangepassState();
}

class _vchangepassState extends State<vchangepass> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _send_data() async {
    String currentpassword = oldpasswordcontroller.text;
    String newpassword = newpasswordcontroller.text;
    String confirmpassword = confirmpasswordcontroller.text;

    // Basic validation
    if (currentpassword.isEmpty || newpassword.isEmpty || confirmpassword.isEmpty) {
      Fluttertoast.showToast(
        msg: 'All fields are required',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (newpassword != confirmpassword) {
      Fluttertoast.showToast(
        msg: 'New password and confirm password do not match',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (newpassword.length < 6) {
      Fluttertoast.showToast(
        msg: 'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/uservchangepass/');
    try {
      final response = await http.post(urls, body: {
        'currentpassword': currentpassword,
        'newpassword': newpassword,
        'confirmpassword': confirmpassword,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(
            msg: 'Password changed successfully',
            backgroundColor: darkPastelBrown,
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => myloginpage(title: '')),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Current password is incorrect',
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Network Error',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => volunteerhome()));
      return false;
    },
      child: Scaffold(
        backgroundColor: warmBackground,
        appBar: AppBar(
          // leading: Container(
          //   margin: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: const Icon(
          //     Icons.arrow_back,
          //     color: Color(0xFF967E76),
          //   ),
          // ),
          leadingWidth: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  warmBackground,
                  lightPastelBrown,
                ],
              ),
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Color(0xFF5C4E3D),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Lock Icon Header
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        darkPastelBrown,
                        mediumPastelBrown,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: darkPastelBrown.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_reset,
                    size: 50,
                    color: Colors.white,
                  ),
                ),

                // Title Text
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Secure your account with a new password',
                  style: TextStyle(
                    fontSize: 14,
                    color: mediumPastelBrown,
                  ),
                ),
                const SizedBox(height: 40),

                // Old Password Field
                _buildPasswordField(
                  controller: oldpasswordcontroller,
                  label: 'Current Password',
                  obscureText: _obscureOldPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // New Password Field
                _buildPasswordField(
                  controller: newpasswordcontroller,
                  label: 'New Password',
                  obscureText: _obscureNewPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                _buildPasswordField(
                  controller: confirmpasswordcontroller,
                  label: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Password Requirements
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightPastelBrown.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: darkPastelBrown,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Password must be at least 6 characters long',
                          style: TextStyle(
                            fontSize: 12,
                            color: mediumPastelBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Save Button
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        darkPastelBrown,
                        mediumPastelBrown,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: darkPastelBrown.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _send_data,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Update Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Decorative Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 2,
                      decoration: BoxDecoration(
                        color: pastelBrown,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.favorite,
                      size: 16,
                      color: darkPastelBrown.withOpacity(0.5),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 30,
                      height: 2,
                      decoration: BoxDecoration(
                        color: pastelBrown,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: darkPastelBrown.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: textBrown),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: mediumPastelBrown,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: darkPastelBrown,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: darkPastelBrown,
            ),
            onPressed: onToggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: lightPastelBrown,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: darkPastelBrown,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}