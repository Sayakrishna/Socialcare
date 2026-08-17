// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:socialcare/user/home.dart';
// import 'package:socialcare/user/signup.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/volunter/volunteerhome.dart';
//
// import 'forgot_password.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
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
//       home: const myloginpage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class myloginpage extends StatefulWidget {
//   const myloginpage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<myloginpage> createState() => _myloginpageState();
// }
//
// class _myloginpageState extends State<myloginpage> {
//   TextEditingController usernamecontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//
//
//
//
//   void _send_data() async {
//     String uname = usernamecontroller.text;
//     String password = passwordcontroller.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/loginapp_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'email': uname,
//         'pass': password,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         String type = jsonDecode(response.body)['type'];
//         if (status == 'ok') {
//
//
//           if(type=='user'){
//             String lid = jsonDecode(response.body)['loginid'];
//             sh.setString("lid", lid);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => userhome()),
//             );
//           }
//           else{
//             String lid = jsonDecode(response.body)['loginid'];
//             sh.setString("lid", lid);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => volunteerhome()),
//             );
//           }
//
//
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
//               controller: usernamecontroller,
//               decoration: InputDecoration(labelText: 'username',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             TextFormField(
//               controller: passwordcontroller,
//               decoration: InputDecoration(labelText: 'password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text('Login')),
//             ElevatedButton(onPressed: (){
//
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Usersignup(title: '',)));
//
//             }, child: Text('Signup')),
//
//             ElevatedButton(onPressed: (){
//
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>forgot_password(title: '',)));
//
//             }, child: Text('Forget Password')),
//
//
//           ],
//         ),
//       ),
//
//     );
//   }
// }




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialcare/user/home.dart';
import 'package:socialcare/user/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/volunter/volunteerhome.dart';

import 'forgot_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialCare',
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
      home: const myloginpage(title: 'Login'),
    );
  }
}

class myloginpage extends StatefulWidget {
  const myloginpage({super.key, required this.title});

  final String title;

  @override
  State<myloginpage> createState() => _myloginpageState();
}

class _myloginpageState extends State<myloginpage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void _send_data() async {
    String uname = usernamecontroller.text;
    String password = passwordcontroller.text;

    if (uname.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/loginapp_post/');
    try {
      final response = await http.post(urls, body: {
        'email': uname,
        'pass': password,
      });

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        String type = jsonDecode(response.body)['type'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['loginid'];
          sh.setString("lid", lid);
          if(type=='user'){

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => userhome()),
            );
          }
          else{
            // String lid = jsonDecode(response.body)['loginid'];
            // sh.setString("lid", lid);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => volunteerhome()),
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Invalid username or password',
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
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Connection Error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF9F5F0),
              const Color(0xFFEAD7C3),
              const Color(0xFFD7C0AE),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo Section
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF967E76),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      size: 50,
                      color: Color(0xFF967E76),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Welcome Text
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5C4E3D),
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.brown.withOpacity(0.1),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue your journey',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF967E76),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Login Form Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: usernamecontroller,
                          style: const TextStyle(
                            color: Color(0xFF5C4E3D),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: const Color(0xFF967E76),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: const Color(0xFFB7A99A),
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: const Color(0xFF967E76),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: const Color(0xFFD7C0AE),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: const Color(0xFF967E76),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: _obscurePassword,
                          style: const TextStyle(
                            color: Color(0xFF5C4E3D),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: const Color(0xFF967E76),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: const Color(0xFFB7A99A),
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: const Color(0xFF967E76),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: const Color(0xFF967E76),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: const Color(0xFFD7C0AE),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: const Color(0xFF967E76),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => forgot_password(title: ''),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: const Color(0xFF967E76),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Login Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFD7C0AE),
                                const Color(0xFFB7A99A),
                                const Color(0xFF967E76),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF967E76).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _send_data,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign Up Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: const Color(0xFF967E76),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Usersignup(title: ''),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: const Color(0xFF5C4E3D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Decorative Elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 1,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7C0AE),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: const Color(0xFF967E76).withOpacity(0.5),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 30,
                        height: 1,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7C0AE),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Footer Text
                  Text(
                    'Making connections that matter',
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFF967E76).withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}