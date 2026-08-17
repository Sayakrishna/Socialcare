// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
//
//
// void main() {
//   runApp(const upgradeprofile(title: 'Upgrade Profile'));
// }
//
// class upgradeprofile extends StatefulWidget {
//   const upgradeprofile({super.key, required this.title});
//   final String title;
//
//   @override
//   State<upgradeprofile> createState() => _upgradeprofileState();
// }
//
// class _upgradeprofileState extends State<upgradeprofile> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController skillstextController =
//   TextEditingController();
//   final TextEditingController assignedAreacontroller =
//   TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//
//
//
//   String _status = 'Active';
//   bool _isWilling = false;
//   bool _obscurePassword = true;
//
//   List categories = [];
//   List<String> selectedCategory = [];
//
//   final List<String> _statusOptions = ['Active', 'Inactive'];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }
//
//   /// FETCH CATEGORIES
//   Future<void> fetchCategories() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     if (url == null) return;
//
//     final response =
//     await http.get(Uri.parse('$url/userviewcategory'));
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         categories = data['data'];
//       });
//     }
//   }
//
//   /// SEND DATA
//   Future<void> _sendData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String? userid = sh.getString('userid').toString();
//     String? useremail = sh.getString('useremail').toString();
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found");
//       return;
//     }
//
//     final uri = Uri.parse('$url/userupgradeprofile/');
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['skills'] = skillstextController.text.trim();
//     request.fields['assigned_area'] = assignedAreacontroller.text.trim();
//     request.fields['status'] = _status;
//     request.fields['userid'] = userid;
//     request.fields['useremail'] = useremail;
//     request.fields['password'] = passwordController.text.trim();
//     request.fields['username'] = usernameController.text.trim();
//
//     /// Send selected category IDs
//     request.fields['categories'] = jsonEncode(selectedCategory); // IDs only
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Profile upgraded successfully");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => userhome()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//
//               /// SKILLS
//               TextFormField(
//                 controller: skillstextController,
//                 decoration: const InputDecoration(
//                   labelText: 'Skills',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? 'Required' : null,
//               ),
//
//               const SizedBox(height: 15),
//
//               /// CATEGORIES
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Select Categories",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ),
//
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics:
//                 const NeverScrollableScrollPhysics(),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final cat = categories[index];
//                   final isChecked = selectedCategory
//                       .contains(cat['id'].toString());
//
//                   return CheckboxListTile(
//                     title:
//                     Text(cat['parentcategory']),
//                     value: isChecked,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == true) {
//                           selectedCategory.add(
//                               cat['id'].toString());
//                         } else {
//                           selectedCategory.remove(
//                               cat['id'].toString());
//                         }
//                       });
//                     },
//                   );
//                 },
//               ),
//
//               const SizedBox(height: 12),
//
//               /// STATUS
//               DropdownButtonFormField<String>(
//                 value: _status,
//                 decoration: const InputDecoration(
//                   labelText: 'Volunteer Status',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: _statusOptions
//                     .map((s) => DropdownMenuItem(
//                   value: s,
//                   child: Text(s),
//                 ))
//                     .toList(),
//                 onChanged: (v) {
//                   setState(() {
//                     _status = v!;
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 12),
//
//               /// ASSIGNED AREA
//               TextFormField(
//                 controller: assignedAreacontroller,
//                 decoration: const InputDecoration(
//                   labelText: 'Assigned Area',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? 'Required' : null,
//               ),
//
//               const SizedBox(height: 12),
//
//
//               TextFormField(
//                 controller: usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   border:
//                   const OutlineInputBorder(),
//                 ),
//                 validator: (v) {
//                   if (v == null || v.isEmpty) {
//                     return 'Required';
//                   }
//                   return null;
//                 },
//               ),
//
//               const SizedBox(height: 15),
//
//               /// PASSWORD
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border:
//                   const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscurePassword
//                         ? Icons.visibility_off
//                         : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword =
//                         !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (v) {
//                   if (v == null || v.isEmpty) {
//                     return 'Required';
//                   }
//                   if (v.length < 6) {
//                     return 'Min 6 characters';
//                   }
//                   return null;
//                 },
//               ),
//
//               const SizedBox(height: 12),
//
//               /// DECLARATION
//               CheckboxListTile(
//                 value: _isWilling,
//                 onChanged: (v) {
//                   setState(() {
//                     _isWilling = v!;
//                   });
//                 },
//                 title: const Text(
//                     "I am willing to work as a volunteer"),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// SUBMIT
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isWilling) {
//                     Fluttertoast.showToast(
//                         msg:
//                         "Accept declaration");
//                     return;
//                   }
//                   if (selectedCategory.isEmpty) {
//                     Fluttertoast.showToast(
//                         msg:
//                         "Select at least one category");
//                     return;
//                   }
//                   if (_formKey.currentState!
//                       .validate()) {
//                     _sendData();
//                   }
//                 },
//                 child: const Text("Submit"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/user/viewprofile.dart';

import 'home.dart';

void main() {
  runApp(const upgradeprofile(title: 'Upgrade to Volunteer'));
}

class upgradeprofile extends StatefulWidget {
  const upgradeprofile({super.key, required this.title});
  final String title;

  @override
  State<upgradeprofile> createState() => _upgradeprofileState();
}

class _upgradeprofileState extends State<upgradeprofile> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController skillstextController = TextEditingController();
  final TextEditingController assignedAreacontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String _status = 'Active';
  bool _isWilling = false;
  bool _obscurePassword = true;

  List categories = [];
  List<String> selectedCategory = [];

  final List<String> _statusOptions = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  /// FETCH CATEGORIES
  Future<void> fetchCategories() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    if (url == null) return;

    final response = await http.get(Uri.parse('$url/userviewcategory'));
    final data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      setState(() {
        categories = data['data'];
      });
    }
  }

  /// SEND DATA
  Future<void> _sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? userid = sh.getString('userid').toString();
    String? useremail = sh.getString('useremail').toString();

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found");
      return;
    }

    final uri = Uri.parse('$url/userupgradeprofile/');
    var request = http.MultipartRequest('POST', uri);

    request.fields['skills'] = skillstextController.text.trim();
    request.fields['assigned_area'] = assignedAreacontroller.text.trim();
    request.fields['status'] = _status;
    request.fields['userid'] = userid;
    request.fields['useremail'] = useremail;
    request.fields['password'] = passwordController.text.trim();
    request.fields['username'] = usernameController.text.trim();

    /// Send selected category IDs
    request.fields['categories'] = jsonEncode(selectedCategory); // IDs only

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Profile upgraded successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => userhome()),
        );
      } else {
        Fluttertoast.showToast(msg: "Submission failed");
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
            widget.title,
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
                          Icons.volunteer_activism,
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
                              'Become a Volunteer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textBrown,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Fill in your details to upgrade your profile',
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

                // Skills Section
                _buildSectionHeader('Skills & Expertise', Icons.handyman_outlined),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: skillstextController,
                  label: 'Enter your skills',
                  icon: Icons.handyman_outlined,
                  validator: (v) => v!.isEmpty ? 'Skills are required' : null,
                ),

                const SizedBox(height: 25),

                // Categories Section
                _buildSectionHeader('Select Categories', Icons.category_outlined),
                const SizedBox(height: 15),
                Container(
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isChecked = selectedCategory.contains(cat['id'].toString());

                      return CheckboxListTile(
                        title: Text(
                          cat['parentcategory'],
                          style: TextStyle(
                            color: textBrown,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: isChecked,
                        activeColor: darkPastelBrown,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              selectedCategory.add(cat['id'].toString());
                            } else {
                              selectedCategory.remove(cat['id'].toString());
                            }
                          });
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Volunteer Status Section
                _buildSectionHeader('Volunteer Status', Icons.assignment_ind_outlined),
                const SizedBox(height: 15),
                Container(
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
                  child: DropdownButtonFormField<String>(
                    value: _status,
                    decoration: InputDecoration(
                      labelText: 'Select Status',
                      labelStyle: TextStyle(color: mediumPastelBrown),
                      prefixIcon: Icon(
                        Icons.circle_outlined,
                        color: darkPastelBrown,
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
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _statusOptions
                        .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(
                        s,
                        style: TextStyle(color: textBrown),
                      ),
                    ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _status = v!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Assigned Area Section
                _buildSectionHeader('Assigned Area', Icons.location_on_outlined),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: assignedAreacontroller,
                  label: 'Enter assigned area',
                  icon: Icons.location_on_outlined,
                  validator: (v) => v!.isEmpty ? 'Assigned area is required' : null,
                ),

                const SizedBox(height: 25),

                // Login Credentials Section
                _buildSectionHeader('Login Credentials', Icons.lock_outline),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: usernameController,
                  label: 'Username',
                  icon: Icons.person_outline,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Password Field
                Container(
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
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: textBrown),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: mediumPastelBrown),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: darkPastelBrown,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: darkPastelBrown,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
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
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Password is required';
                      }
                      if (v.length < 6) {
                        return 'Minimum 6 characters required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Declaration Section
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightPastelBrown.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: lightPastelBrown,
                      width: 1,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: _isWilling,
                    onChanged: (v) {
                      setState(() {
                        _isWilling = v!;
                      });
                    },
                    activeColor: darkPastelBrown,
                    checkColor: Colors.white,
                    title: Text(
                      "I am willing to work as a volunteer",
                      style: TextStyle(
                        color: textBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                      if (!_isWilling) {
                        Fluttertoast.showToast(
                          msg: "Please accept the declaration",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      if (selectedCategory.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Select at least one category",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        _sendData();
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
                      "Submit Application",
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