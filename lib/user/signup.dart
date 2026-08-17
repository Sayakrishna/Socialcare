// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:socialcare/login.dart';
//
//
// void main() {
//   runApp( Usersignup(title: '',));
// }
//
// class Usersignup extends StatefulWidget {
//   const Usersignup({super.key, required this.title});
//
//   final String title;
//   @override
//   State<Usersignup> createState() => _UsersignupState();
//
// }
// class _UsersignupState extends State<Usersignup> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nametextController = TextEditingController();
//   final TextEditingController _emailtextController = TextEditingController();
//   final TextEditingController _phonenotextController = TextEditingController();
//   final TextEditingController _districttextController = TextEditingController();
//   final TextEditingController _placetextController = TextEditingController();
//   final TextEditingController _posttextController = TextEditingController();
//   final TextEditingController _pintextController = TextEditingController();
//   final TextEditingController _idnumtextController = TextEditingController();
//   final TextEditingController _roletextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//   final TextEditingController _confirmpasswordtextController = TextEditingController();
//
//   File? _selectedImage;
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//     else {
//       Fluttertoast.showToast(msg: "No image selected");
//     }
//   }
//
//   Future<void> _sendData() async {
//     String name = _nametextController.text;
//     String email = _emailtextController.text;
//     String phone = _phonenotextController.text;
//     String district = _districttextController.text;
//     String place = _placetextController.text;
//     String post = _posttextController.text;
//     String pin = _pintextController.text;
//     String role = _idnumtextController.text;
//     String idnum = _roletextController.text;
//     String password = _passwordtextController.text;
//     String confirmpassword = _confirmpasswordtextController.text;
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/usersignup_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = name;
//     request.fields['phonenum'] = phone;
//     request.fields['email'] = email;
//     request.fields['district'] = district;
//     request.fields['place'] = place;
//     request.fields['post'] = post;
//     request.fields['pin'] = pin;
//     request.fields['idnum'] = idnum;
//     request.fields['role'] = role;
//     request.fields['password'] = password;
//     request.fields['confirmpassword'] = confirmpassword;
//
//     if (_selectedImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>myloginpage(title: '',)));
//
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>myloginpage(title: '',)));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           foregroundColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // _selectedImage != null
//                 //     ? Image.file(_selectedImage!, height: 150)
//                 //     : const Text("No Image Selected"),
//                 // const SizedBox(height: 10),
//                 // ElevatedButton(
//                 //   onPressed: _chooseImage,
//                 //   child: const Text("Choose Image"),
//                 // ),
//                 // const SizedBox(height: 20),
//
//
//                 TextFormField(
//                   controller: _nametextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   controller: _emailtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Email is required';
//                     }
//                     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _phonenotextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone number is required';
//                     }
//                     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//
//                 TextFormField(
//                   controller: _districttextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your district',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'District is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 TextFormField(
//                   controller: _placetextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your place',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'place is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 TextFormField(
//                   controller: _posttextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your post',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'post is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//
//                 TextFormField(
//                   controller: _pintextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your pin',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'pin is required';
//                     }
//                     if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   controller: _idnumtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'enter your idnum',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'idnumber is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 10),
//
//
//                 TextFormField(
//                   controller: _roletextController,
//                   decoration: const InputDecoration(
//                     labelText: 'enter your role',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'role is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 10),
//
//
//
//                 TextFormField(
//                   controller: _passwordtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'password is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//
//
//                 TextFormField(
//                   controller: _confirmpasswordtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'confirm password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'password is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//
//
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendData();
//                     } else {
//                       Fluttertoast.showToast(msg: "Please fix errors in the form");
//                     }
//                   },
//                   child: const Text("Submit"),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socialcare/login.dart';

void main() {
  runApp(const Usersignup(title: ''));
}

class Usersignup extends StatefulWidget {
  const Usersignup({super.key, required this.title});

  final String title;
  @override
  State<Usersignup> createState() => _UsersignupState();
}

class _UsersignupState extends State<Usersignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nametextController = TextEditingController();
  final TextEditingController _emailtextController = TextEditingController();
  final TextEditingController _phonenotextController = TextEditingController();
  final TextEditingController _districttextController = TextEditingController();
  final TextEditingController _placetextController = TextEditingController();
  final TextEditingController _posttextController = TextEditingController();
  final TextEditingController _pintextController = TextEditingController();
  final TextEditingController _idnumtextController = TextEditingController();
  final TextEditingController _roletextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final TextEditingController _confirmpasswordtextController = TextEditingController();

  File? _selectedImage;
  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(
        msg: "No image selected",
        backgroundColor: const Color(0xFFC4A484), // Pastel brown
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }

  Future<void> _sendData() async {
    String name = _nametextController.text;
    String email = _emailtextController.text;
    String phone = _phonenotextController.text;
    String district = _districttextController.text;
    String place = _placetextController.text;
    String post = _posttextController.text;
    String pin = _pintextController.text;
    String role = _idnumtextController.text;
    String idnum = _roletextController.text;
    String password = _passwordtextController.text;
    String confirmpassword = _confirmpasswordtextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      Fluttertoast.showToast(
        msg: "Server URL not found.",
        backgroundColor: const Color(0xFFC4A484), // Pastel brown
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    final uri = Uri.parse('$url/usersignup_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['phonenum'] = phone;
    request.fields['email'] = email;
    request.fields['district'] = district;
    request.fields['place'] = place;
    request.fields['post'] = post;
    request.fields['pin'] = pin;
    request.fields['idnum'] = idnum;
    request.fields['role'] = role;
    request.fields['password'] = password;
    request.fields['confirmpassword'] = confirmpassword;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(
          msg: "Submitted successfully.",
          backgroundColor: const Color(0xFFC4A484), // Pastel brown
          textColor: Colors.white,
          fontSize: 16,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => myloginpage(title: '')));
      } else {
        Fluttertoast.showToast(
          msg: "Submission failed.",
          backgroundColor: const Color(0xFFC4A484), // Pastel brown
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: const Color(0xFFC4A484), // Pastel brown
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => myloginpage(title: '')));
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Account",
              style: const TextStyle(
                color: Color(0xFFFDF8F2), // Cream white
                fontFamily: 'Georgia',
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD9B382), // Pastel brown
                    Color(0xFFC4A484), // Slightly darker pastel brown
                  ],
                ),
              ),
            ),
            elevation: 2,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFDF3E4), // Soft cream
                  const Color(0xFFF5E6D3), // Light cream brown
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Decorative header
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8D5B5).withOpacity(0.3), // Light pastel tan
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFE8D5B5), // Light pastel tan
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_add_alt_1,
                            color: const Color(0xFFD9B382), // Pastel brown
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Join Our Community",
                            style: TextStyle(
                              color: Color(0xFF8B6B4D), // Muted brown
                              fontSize: 18,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Image picker section (commented out but styled)
                    // if (_selectedImage != null)
                    //   Container(
                    //     height: 150,
                    //     width: 150,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(75),
                    //       border: Border.all(
                    //         color: const Color(0xFFD9B382), // Pastel brown
                    //         width: 3,
                    //       ),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: const Color(0xFFD9B382).withOpacity(0.3),
                    //           blurRadius: 10,
                    //           offset: const Offset(0, 5),
                    //         ),
                    //       ],
                    //     ),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(75),
                    //       child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    //     ),
                    //   ),
                    // const SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: _chooseImage,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: const Color(0xFFE8D5B5), // Light pastel tan
                    //     foregroundColor: const Color(0xFF8B6B4D), // Muted brown
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    //   ),
                    //   child: const Text("Choose Profile Photo"),
                    // ),
                    // const SizedBox(height: 20),

                    // Personal Information Section
                    _buildSectionHeader("Personal Information", Icons.person),

                    _buildTextField(
                      controller: _nametextController,
                      label: "Full Name",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _emailtextController,
                      label: "Email Address",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _phonenotextController,
                      label: "Phone Number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Address Information Section
                    _buildSectionHeader("Address Details", Icons.location_on_outlined),

                    _buildTextField(
                      controller: _districttextController,
                      label: "District",
                      icon: Icons.location_city_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'District is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _placetextController,
                      label: "Place",
                      icon: Icons.place_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Place is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _posttextController,
                      label: "Post Office",
                      icon: Icons.markunread_mailbox_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Post is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _pintextController,
                      label: "PIN Code",
                      icon: Icons.pin_drop_outlined,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'PIN is required';
                        }
                        if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                          return 'Enter a valid 6-digit PIN';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Identity Information Section
                    _buildSectionHeader("Identity Details", Icons.badge_outlined),

                    _buildTextField(
                      controller: _idnumtextController,
                      label: "ID Number",
                      icon: Icons.credit_card_outlined,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'ID number is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _roletextController,
                      label: "Role",
                      icon: Icons.work_outline_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Role is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Security Section
                    _buildSectionHeader("Security", Icons.security_outlined),

                    _buildTextField(
                      controller: _passwordtextController,
                      label: "Password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildTextField(
                      controller: _confirmpasswordtextController,
                      label: "Confirm Password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordtextController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    // Submit Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFD9B382), // Pastel brown
                            Color(0xFFC4A484), // Slightly darker pastel brown
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD9B382).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sendData();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please fix errors in the form",
                              backgroundColor: const Color(0xFFC4A484), // Pastel brown
                              textColor: Colors.white,
                              fontSize: 16,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: const Color(0xFFFDF8F2), // Cream white
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Georgia',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                            fontFamily: 'Georgia',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => myloginpage(title: '')),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFFD9B382), // Pastel brown
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Decorative footer
                    Text(
                      "Your information is secure with us",
                      style: TextStyle(
                        color: const Color(0xFFC4A484).withOpacity(0.7), // Pastel brown
                        fontSize: 12,
                        fontFamily: 'Georgia',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8D5B5), // Light pastel tan
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8B6B4D), // Muted brown
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B4F36), // Dark muted brown
              fontFamily: 'Georgia',
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build styled text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD9B382).withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(
          color: Color(0xFF5C3E2E), // Dark brown text
          fontFamily: 'Georgia',
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF8B6B4D), // Muted brown
            fontFamily: 'Georgia',
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFD9B382), // Pastel brown
          ),
          filled: true,
          fillColor: const Color(0xFFFFF8F0), // Cream
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFE8D5B5), // Light pastel tan
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFE8D5B5), // Light pastel tan
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFD9B382), // Pastel brown
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFE8A5A5), // Soft red for errors
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFE8A5A5), // Soft red for errors
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: validator,
      ),
    );
  }
}