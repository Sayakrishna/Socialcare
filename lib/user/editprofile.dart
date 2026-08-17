// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:socialcare/user/viewprofile.dart';
//
//
// void main() {
//   runApp( user_edit_profile(title: '',));
// }
//
// class user_edit_profile extends StatefulWidget {
//   const user_edit_profile({super.key, required this.title});
//
//   final String title;
//   @override
//   State<user_edit_profile> createState() => _user_edit_profileState();
//
// }
// class _user_edit_profileState extends State<user_edit_profile> {
//   _user_edit_profileState(){
//     _send_data();
//   }
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
//
//   void _send_data() async{
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_viewprofile/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid':lid
//
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String name=jsonDecode(response.body)['name'];
//           String phonenumber=jsonDecode(response.body)['phonenum'];
//           String email=jsonDecode(response.body)['email'];
//           String district=jsonDecode(response.body)['district'];
//           String place=jsonDecode(response.body)['place'];
//           String post=jsonDecode(response.body)['post'];
//           String pin=jsonDecode(response.body)['pin'];
//           String status=jsonDecode(response.body)['status'];
//           String idnum=jsonDecode(response.body)['idnum'];
//           String role=jsonDecode(response.body)['role'];
//
//           setState(() {
//
//             _nametextController.text= name;
//             _emailtextController.text= email;
//             _phonenotextController.text= phonenumber;
//             _placetextController.text= place;
//             _posttextController.text= post;
//             _pintextController.text= pin;
//             _districttextController.text= district;
//             _idnumtextController.text= idnum;
//             _roletextController.text= role;
//
//
//
//
//           });
//
//
//
//
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
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
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? lid = sh.getString('lid');
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/usereditprofile_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['lid'] = lid!;
//     request.fields['name'] = name;
//     request.fields['phonenum'] = phone;
//     request.fields['email'] = email;
//     request.fields['district'] = district;
//     request.fields['place'] = place;
//     request.fields['post'] = post;
//     request.fields['pin'] = pin;
//     request.fields['idnum'] = idnum;
//     request.fields['role'] = role;
//     //
//     //
//     // if (_selectedImage != null) {
//     //   request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     // }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfilePage(title: '',)));
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
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfilePage(title: '',)));
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
//
//
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
//
//
//
//
//
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
import 'package:socialcare/user/viewprofile.dart';

void main() {
  runApp(user_edit_profile(title: ''));
}

class user_edit_profile extends StatefulWidget {
  const user_edit_profile({super.key, required this.title});

  final String title;
  @override
  State<user_edit_profile> createState() => _user_edit_profileState();
}

class _user_edit_profileState extends State<user_edit_profile> {
  _user_edit_profileState() {
    _send_data();
  }

  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

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

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String phonenumber = jsonDecode(response.body)['phonenum'];
          String email = jsonDecode(response.body)['email'];
          String district = jsonDecode(response.body)['district'];
          String place = jsonDecode(response.body)['place'];
          String post = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'];
          String status = jsonDecode(response.body)['status'];
          String idnum = jsonDecode(response.body)['idnum'];
          String role = jsonDecode(response.body)['role'];

          setState(() {
            _nametextController.text = name;
            _emailtextController.text = email;
            _phonenotextController.text = phonenumber;
            _placetextController.text = place;
            _posttextController.text = post;
            _pintextController.text = pin;
            _districttextController.text = district;
            _idnumtextController.text = idnum;
            _roletextController.text = role;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  File? _selectedImage;
  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No image selected");
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

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? lid = sh.getString('lid');
    String? url = sh.getString('url');

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/usereditprofile_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['lid'] = lid!;
    request.fields['name'] = name;
    request.fields['phonenum'] = phone;
    request.fields['email'] = email;
    request.fields['district'] = district;
    request.fields['place'] = place;
    request.fields['post'] = post;
    request.fields['pin'] = pin;
    request.fields['idnum'] = idnum;
    request.fields['role'] = role;

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Profile updated successfully.");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: '')));
      } else {
        Fluttertoast.showToast(msg: "Update failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: '')));
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
            widget.title.isNotEmpty ? widget.title : 'Edit Profile',
            style: const TextStyle(
              color: Color(0xFF5C4E3D),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Profile Image Section (commented out as in original)
                // Container(
                //   margin: const EdgeInsets.only(bottom: 20),
                //   child: Column(
                //     children: [
                //       Container(
                //         width: 120,
                //         height: 120,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           gradient: LinearGradient(
                //             colors: [
                //               darkPastelBrown,
                //               mediumPastelBrown,
                //             ],
                //           ),
                //           boxShadow: [
                //             BoxShadow(
                //               color: darkPastelBrown.withOpacity(0.3),
                //               blurRadius: 10,
                //               offset: const Offset(0, 5),
                //             ),
                //           ],
                //         ),
                //         child: _selectedImage != null
                //             ? ClipRRect(
                //                 borderRadius: BorderRadius.circular(60),
                //                 child: Image.file(_selectedImage!, fit: BoxFit.cover),
                //               )
                //             : const Center(
                //                 child: Text(
                //                   'U',
                //                   style: TextStyle(
                //                     fontSize: 48,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //       ),
                //       const SizedBox(height: 10),
                //       TextButton.icon(
                //         onPressed: _chooseImage,
                //         icon: Icon(Icons.camera_alt, color: darkPastelBrown),
                //         label: Text(
                //           'Change Photo',
                //           style: TextStyle(color: darkPastelBrown),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Header Section
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        lightPastelBrown.withOpacity(0.5),
                        pastelBrown.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: darkPastelBrown.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: darkPastelBrown,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Your Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textBrown,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Update your personal information below',
                              style: TextStyle(
                                fontSize: 13,
                                color: mediumPastelBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal Information Section
                _buildSectionHeader('Personal Information', Icons.person_outline),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _nametextController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _emailtextController,
                  label: 'Email Address',
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

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _phonenotextController,
                  label: 'Phone Number',
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

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _idnumtextController,
                  label: 'ID Number',
                  icon: Icons.badge_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ID number is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _roletextController,
                  label: 'Role',
                  icon: Icons.work_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Role is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // Address Information Section
                _buildSectionHeader('Address Details', Icons.location_on_outlined),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _districttextController,
                  label: 'District',
                  icon: Icons.map_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'District is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _placetextController,
                  label: 'Place',
                  icon: Icons.location_city,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Place is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _posttextController,
                  label: 'Post Office',
                  icon: Icons.local_post_office_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Post is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                _buildTextField(
                  controller: _pintextController,
                  label: 'PIN Code',
                  icon: Icons.pin_drop,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'PIN is required';
                    }
                    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                      return 'Enter a valid 6-digit PIN code';
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendData();
                      } else {
                        Fluttertoast.showToast(msg: "Please fix errors in the form");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Update Profile",
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightPastelBrown.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: darkPastelBrown,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textBrown,
          ),
        ),
        const Spacer(),
        Container(
          width: 50,
          height: 2,
          decoration: BoxDecoration(
            color: pastelBrown,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
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
        keyboardType: keyboardType,
        style: TextStyle(color: textBrown),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: mediumPastelBrown,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: darkPastelBrown,
            size: 20,
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
        validator: validator,
      ),
    );
  }
}