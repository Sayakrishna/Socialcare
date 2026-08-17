// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/volunter/volunteerviewprofile.dart';
//
// class VolunteerEditProfile extends StatefulWidget {
//   const VolunteerEditProfile({super.key});
//
//   @override
//   State<VolunteerEditProfile> createState() =>
//       _VolunteerEditProfileState();
// }
//
// class _VolunteerEditProfileState
//     extends State<VolunteerEditProfile> {
//
//   final GlobalKey<FormState> _formKey =
//   GlobalKey<FormState>();
//
//   final TextEditingController skillsController =
//   TextEditingController();
//   final TextEditingController assignedAreaController =
//   TextEditingController();
//
//   String _status = 'Active';
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
//     fetchProfile();
//   }
//
//   /// FETCH CATEGORIES
//   Future<void> fetchCategories() async {
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
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
//   /// FETCH EXISTING PROFILE DATA
//   Future<void> fetchProfile() async {
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse('$url/volunteer_viewprofile/'),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         skillsController.text = data['skills'];
//         assignedAreaController.text =
//         data['assigned_area'];
//         _status = data['volunteer_status'];
//
//         /// already selected categories
//         selectedCategory =
//         List<String>.from(data['categories']);
//       });
//     }
//   }
//
//   /// UPDATE PROFILE
//   Future<void> updateProfile() async {
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid').toString();
//
//     final response = await http.post(
//       Uri.parse('$url/volunteereditprofile_post/'),
//       body: {
//         'lid': lid,
//         'skills': skillsController.text,
//         'assignedarea': assignedAreaController.text,
//         'status': _status,
//         'categories': jsonEncode(selectedCategory),
//       },
//     );
//
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       Fluttertoast.showToast(
//           msg: "Profile updated successfully");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>volunteerviewprofile(title: '',)));
//     } else {
//       Fluttertoast.showToast(
//           msg: "Update failed");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Volunteer Profile"),
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
//                 controller: skillsController,
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
//               /// STATUS DROPDOWN
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
//                 controller: assignedAreaController,
//                 decoration: const InputDecoration(
//                   labelText: 'Assigned Area',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? 'Required' : null,
//               ),
//
//               const SizedBox(height: 20),
//
//               /// UPDATE BUTTON
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedCategory.isEmpty) {
//                     Fluttertoast.showToast(
//                         msg:
//                         "Select at least one category");
//                     return;
//                   }
//                   if (_formKey.currentState!
//                       .validate()) {
//                     updateProfile();
//                   }
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/volunter/volunteerviewprofile.dart';
//
// class VolunteerEditProfile extends StatefulWidget {
//   const VolunteerEditProfile({super.key});
//
//   @override
//   State<VolunteerEditProfile> createState() => _VolunteerEditProfileState();
// }
//
// class _VolunteerEditProfileState extends State<VolunteerEditProfile> {
//   // Pastel brown color palette
//   final Color pastelBrown = const Color(0xFFD7C0AE);
//   final Color lightPastelBrown = const Color(0xFFEAD7C3);
//   final Color mediumPastelBrown = const Color(0xFFB7A99A);
//   final Color darkPastelBrown = const Color(0xFF967E76);
//   final Color warmBackground = const Color(0xFFF9F5F0);
//   final Color textBrown = const Color(0xFF5C4E3D);
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController skillsController = TextEditingController();
//   final TextEditingController assignedAreaController = TextEditingController();
//
//   String _status = 'Active';
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
//     fetchProfile();
//   }
//
//   /// FETCH CATEGORIES
//   Future<void> fetchCategories() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.get(Uri.parse('$url/userviewcategory'));
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         categories = data['data'];
//       });
//     }
//   }
//
//   /// FETCH EXISTING PROFILE DATA
//   Future<void> fetchProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse('$url/volunteer_viewprofile/'),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         skillsController.text = data['skills'];
//         assignedAreaController.text = data['assigned_area'];
//         _status = data['volunteer_status'];
//
//         /// already selected categories
//         selectedCategory = List<String>.from(data['categories']);
//       });
//     }
//   }
//
//   /// UPDATE PROFILE
//   Future<void> updateProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid').toString();
//
//     final response = await http.post(
//       Uri.parse('$url/volunteereditprofile_post/'),
//       body: {
//         'lid': lid,
//         'skills': skillsController.text,
//         'assignedarea': assignedAreaController.text,
//         'status': _status,
//         'categories': jsonEncode(selectedCategory),
//       },
//     );
//
//     final data = jsonDecode(response.body);
//
//     if (data['status'] == 'ok') {
//       Fluttertoast.showToast(msg: "Profile updated successfully");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => volunteerviewprofile(title: '')),
//       );
//     } else {
//       Fluttertoast.showToast(msg: "Update failed");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: warmBackground,
//       appBar: AppBar(
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.arrow_back,
//             color: Color(0xFF967E76),
//           ),
//         ),
//         leadingWidth: 50,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 warmBackground,
//                 lightPastelBrown,
//               ],
//             ),
//           ),
//         ),
//         title: const Text(
//           'Edit Volunteer Profile',
//           style: TextStyle(
//             color: Color(0xFF5C4E3D),
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Header Section
//               Container(
//                 margin: const EdgeInsets.only(bottom: 25),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       lightPastelBrown.withOpacity(0.5),
//                       pastelBrown.withOpacity(0.3),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: darkPastelBrown.withOpacity(0.2),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.volunteer_activism,
//                         color: darkPastelBrown,
//                         size: 28,
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Edit Your Profile',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: textBrown,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             'Update your volunteer information',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: mediumPastelBrown,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Skills Section
//               _buildSectionHeader('Skills & Expertise', Icons.handyman_outlined),
//               const SizedBox(height: 15),
//               _buildTextField(
//                 controller: skillsController,
//                 label: 'Enter your skills',
//                 icon: Icons.handyman_outlined,
//                 validator: (v) => v!.isEmpty ? 'Skills are required' : null,
//               ),
//
//               const SizedBox(height: 25),
//
//               // Categories Section
//               _buildSectionHeader('Select Categories', Icons.category_outlined),
//               const SizedBox(height: 15),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: darkPastelBrown.withOpacity(0.05),
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     final cat = categories[index];
//                     final isChecked = selectedCategory.contains(cat['id'].toString());
//
//                     return CheckboxListTile(
//                       title: Text(
//                         cat['parentcategory'],
//                         style: TextStyle(
//                           color: textBrown,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       value: isChecked,
//                       activeColor: darkPastelBrown,
//                       checkColor: Colors.white,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value == true) {
//                             selectedCategory.add(cat['id'].toString());
//                           } else {
//                             selectedCategory.remove(cat['id'].toString());
//                           }
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               // Volunteer Status Section
//               _buildSectionHeader('Volunteer Status', Icons.assignment_ind_outlined),
//               const SizedBox(height: 15),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: darkPastelBrown.withOpacity(0.05),
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   value: _status,
//                   decoration: InputDecoration(
//                     labelText: 'Select Status',
//                     labelStyle: TextStyle(color: mediumPastelBrown),
//                     prefixIcon: Icon(
//                       Icons.circle_outlined,
//                       color: darkPastelBrown,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: lightPastelBrown,
//                         width: 1,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: darkPastelBrown,
//                         width: 2,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 16,
//                     ),
//                   ),
//                   items: _statusOptions
//                       .map((s) => DropdownMenuItem(
//                     value: s,
//                     child: Text(
//                       s,
//                       style: TextStyle(color: textBrown),
//                     ),
//                   ))
//                       .toList(),
//                   onChanged: (v) {
//                     setState(() {
//                       _status = v!;
//                     });
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               // Assigned Area Section
//               _buildSectionHeader('Assigned Area', Icons.location_on_outlined),
//               const SizedBox(height: 15),
//               _buildTextField(
//                 controller: assignedAreaController,
//                 label: 'Enter assigned area',
//                 icon: Icons.location_on_outlined,
//                 validator: (v) => v!.isEmpty ? 'Assigned area is required' : null,
//               ),
//
//               const SizedBox(height: 30),
//
//               // Update Button
//               Container(
//                 width: double.infinity,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       darkPastelBrown,
//                       mediumPastelBrown,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: darkPastelBrown.withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (selectedCategory.isEmpty) {
//                       Fluttertoast.showToast(
//                         msg: "Select at least one category",
//                         backgroundColor: Colors.red,
//                         textColor: Colors.white,
//                       );
//                       return;
//                     }
//                     if (_formKey.currentState!.validate()) {
//                       updateProfile();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.save,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       const Text(
//                         "Update Profile",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Decorative Footer
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 30,
//                     height: 2,
//                     decoration: BoxDecoration(
//                       color: pastelBrown,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Icon(
//                     Icons.favorite,
//                     size: 16,
//                     color: darkPastelBrown.withOpacity(0.5),
//                   ),
//                   const SizedBox(width: 10),
//                   Container(
//                     width: 30,
//                     height: 2,
//                     decoration: BoxDecoration(
//                       color: pastelBrown,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title, IconData icon) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: lightPastelBrown.withOpacity(0.5),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: darkPastelBrown,
//             size: 18,
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: textBrown,
//           ),
//         ),
//         const Spacer(),
//         Container(
//           width: 50,
//           height: 2,
//           decoration: BoxDecoration(
//             color: pastelBrown,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: darkPastelBrown.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: TextStyle(color: textBrown),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(
//             color: mediumPastelBrown,
//             fontSize: 14,
//           ),
//           prefixIcon: Icon(
//             icon,
//             color: darkPastelBrown,
//             size: 20,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(
//               color: lightPastelBrown,
//               width: 1,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(
//               color: darkPastelBrown,
//               width: 2,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(
//               color: Colors.red,
//               width: 1,
//             ),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//         validator: validator,
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/volunter/volunteerviewprofile.dart';

import 'volunteerhome.dart';

class VolunteerEditProfile extends StatefulWidget {
  const VolunteerEditProfile({super.key});

  @override
  State<VolunteerEditProfile> createState() => _VolunteerEditProfileState();
}

class _VolunteerEditProfileState extends State<VolunteerEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController skillsController = TextEditingController();
  final TextEditingController assignedAreaController = TextEditingController();

  String _status = 'Active';

  List categories = [];

  /// 🔥 Important Lists
  List<String> selectedCategoryNames = []; // For checkbox match
  List<String> selectedCategoryIds = []; // For update

  final List<String> _statusOptions = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// 🔥 Load Categories First, Then Profile
  Future<void> loadData() async {
    await fetchCategories();
    await fetchProfile();
  }

  /// FETCH ALL CATEGORIES
  Future<void> fetchCategories() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;

    final response = await http.get(Uri.parse('$url/userviewcategory'));
    final data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      setState(() {
        categories = data['data'];
      });
    }
  }

  /// FETCH PROFILE DATA
  Future<void> fetchProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    String lid = sh.getString('lid')!;

    final response = await http.post(
      Uri.parse('$url/volunteer_viewprofile/'),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      setState(() {
        skillsController.text = data['skills'];
        assignedAreaController.text = data['assigned_area'];
        _status = data['volunteer_status'];

        /// 🔥 Names from backend
        selectedCategoryNames =
            (data['categories'] as List).map((e) => e.toString()).toList();

        /// 🔥 Convert names → IDs
        selectedCategoryIds.clear();
        for (var cat in categories) {
          if (selectedCategoryNames.contains(cat['parentcategory'])) {
            selectedCategoryIds.add(cat['id'].toString());
          }
        }
      });
    }
  }

  /// UPDATE PROFILE
  Future<void> updateProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    String lid = sh.getString('lid')!;

    final response = await http.post(
      Uri.parse('$url/volunteereditprofile_post/'),
      body: {
        'lid': lid,
        'skills': skillsController.text,
        'assignedarea': assignedAreaController.text,
        'status': _status,
        'categories': jsonEncode(selectedCategoryIds),
      },
    );

    final data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      Fluttertoast.showToast(msg: "Profile updated successfully");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => volunteerviewprofile(title: '')),
      );
    } else {
      Fluttertoast.showToast(msg: "Update failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => volunteerviewprofile(
                    title: '',
                  )),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Volunteer Profile"),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => volunteerviewprofile(
                          title: '',
                        )),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// SKILLS
                TextFormField(
                  controller: skillsController,
                  decoration: const InputDecoration(labelText: "Skills"),
                  validator: (v) => v!.isEmpty ? "Skills required" : null,
                ),

                const SizedBox(height: 20),

                /// CATEGORIES
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select Categories",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];

                    final isChecked =
                        selectedCategoryNames.contains(cat['parentcategory']);

                    return CheckboxListTile(
                      title: Text(cat['parentcategory']),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedCategoryNames.add(cat['parentcategory']);
                            selectedCategoryIds.add(cat['id'].toString());
                          } else {
                            selectedCategoryNames.remove(cat['parentcategory']);
                            selectedCategoryIds.remove(cat['id'].toString());
                          }
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// STATUS
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration:
                      const InputDecoration(labelText: "Volunteer Status"),
                  items: _statusOptions
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _status = v!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                /// ASSIGNED AREA
                TextFormField(
                  controller: assignedAreaController,
                  decoration: const InputDecoration(labelText: "Assigned Area"),
                  validator: (v) =>
                      v!.isEmpty ? "Assigned area required" : null,
                ),

                const SizedBox(height: 30),

                /// UPDATE BUTTON
                ElevatedButton(
                  onPressed: () {
                    if (selectedCategoryIds.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Select at least one category");
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      updateProfile();
                    }
                  },
                  child: const Text("Update Profile"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
