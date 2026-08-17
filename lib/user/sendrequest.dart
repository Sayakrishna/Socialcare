// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// import 'home.dart';
//
//
// void main() {
//   runApp( sendrequest(title: '',));
// }
//
// class sendrequest extends StatefulWidget {
//   const sendrequest({super.key, required this.title});
//
//   final String title;
//   @override
//   State<sendrequest> createState() => _sendrequestState();
//
// }
//
// class _sendrequestState extends State<sendrequest> {
//   _sendrequestState(){
//     fetchCat();
//   }
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _requestamounttextController = TextEditingController();
//   final TextEditingController _requestitemtextController = TextEditingController();
//   final TextEditingController _quantitytextController = TextEditingController();
//   final TextEditingController _urgencylevelttextController = TextEditingController();
//   String drop='low';
//   List<String> urgency=['high','medium','low'];
//
//   List<int> subIds = <int>[];
//   List<String> subNames = <String>[];
//   String? selectedSubName;
//   int? selectedSubId;
//
//
//
//   Future<void> fetchCat() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? baseUrl = sh.getString('url');
//     if (baseUrl == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$baseUrl/userviewcategory/');
//     print('Fetching departments from: $uri');
//
//     try {
//       var response = await http.post(uri, body: {});
//       print('Response code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         var jsondata = json.decode(response.body);
//         if (jsondata['status'] == 'ok') {
//           var dataList = jsondata["data"];
//           List<int> tempIds = [];
//           List<String> tempNames = [];
//
//           for (var item in dataList) {
//             tempIds.add(item['id']);
//             tempNames.add(item['parentcategory'].toString());
//           }
//
//           setState(() {
//             subIds = tempIds;
//             subNames = tempNames;
//             if (subNames.isNotEmpty) {
//               selectedSubName = subNames[0];
//               selectedSubId = subIds[0];
//             }
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Failed to load category: ${jsondata['msg'] ?? 'unknown error'}");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error loading category: $e");
//       print("Exception: $e");
//     }
//   }
//
//
//   Future<void> _sendData() async {
//     String requestamount = _requestamounttextController.text;
//     String requestitem = _requestitemtextController.text;
//     String quantity = _quantitytextController.text;
//     // String district = _urgencylevelttextController.text;
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String? lid = sh.getString('lid');
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/useresendrequest_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['request_amount'] = requestamount;
//     request.fields['request_item'] = requestitem;
//     request.fields['quantity'] = quantity;
//     request.fields['category'] = selectedSubId.toString();
//     request.fields['lid'] = lid!;
//     request.fields['urgency_level'] = drop;
//
//
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
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
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
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
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
//                   controller: _requestamounttextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter the amount',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'amount is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   controller: _requestitemtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your item',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'item is required';
//                     }
//
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _quantitytextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter the quantity',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'quantity number is required';
//                     }
//
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 DropdownButton(value:drop,items: urgency.map((String value){
//                   return DropdownMenuItem(value:value,child: Text(value));
//                 }).toList(), onChanged: (newvalue){
//                   setState(() {
//                     drop=newvalue!;
//                   });
//                 }),
//
//
//
//
//
//                 DropdownButtonFormField<String>(
//                   value: selectedSubName,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Category',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: subNames.map((String dept) {
//                     return DropdownMenuItem<String>(
//                       value: dept,
//                       child: Text(dept),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedSubName = newValue;
//                       selectedSubId = subIds[subNames.indexOf(newValue!)];
//
//                       // selectedDepartmentId = departmentIds[departmentNames.indexOf(newValue!)];
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Please select a Category';
//                     return null;
//                   },
//                 ),
//
//
//                 //
//                 // TextFormField(
//                 //   controller: _urgencylevelttextController,
//                 //   decoration: const InputDecoration(
//                 //     labelText: 'Enter Your district',
//                 //     border: OutlineInputBorder(),
//                 //   ),
//                 //   validator: (value) {
//                 //     if (value == null || value.trim().isEmpty) {
//                 //       return 'District is required';
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//
//                 const SizedBox(height: 20),
//
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

import 'home.dart';

void main() {
  runApp(sendrequest(title: 'Send Request'));
}

class sendrequest extends StatefulWidget {
  const sendrequest({super.key, required this.title});

  final String title;
  @override
  State<sendrequest> createState() => _sendrequestState();
}

class _sendrequestState extends State<sendrequest> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  _sendrequestState() {
    fetchCat();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _requestamounttextController = TextEditingController();
  final TextEditingController _requestitemtextController = TextEditingController();
  final TextEditingController _quantitytextController = TextEditingController();
  final TextEditingController _urgencylevelttextController = TextEditingController();
  String drop = 'low';
  List<String> urgency = ['high', 'medium', 'low'];

  List<int> subIds = <int>[];
  List<String> subNames = <String>[];
  String? selectedSubName;
  int? selectedSubId;

  Future<void> fetchCat() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? baseUrl = sh.getString('url');
    if (baseUrl == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$baseUrl/userviewcategory/');
    print('Fetching departments from: $uri');

    try {
      var response = await http.post(uri, body: {});
      print('Response code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata['status'] == 'ok') {
          var dataList = jsondata["data"];
          List<int> tempIds = [];
          List<String> tempNames = [];

          for (var item in dataList) {
            tempIds.add(item['id']);
            tempNames.add(item['parentcategory'].toString());
          }

          setState(() {
            subIds = tempIds;
            subNames = tempNames;
            if (subNames.isNotEmpty) {
              selectedSubName = subNames[0];
              selectedSubId = subIds[0];
            }
          });
        } else {
          Fluttertoast.showToast(msg: "Failed to load category: ${jsondata['msg'] ?? 'unknown error'}");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error loading category: $e");
      print("Exception: $e");
    }
  }

  Future<void> _sendData() async {
    String requestamount = _requestamounttextController.text;
    String requestitem = _requestitemtextController.text;
    String quantity = _quantitytextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid');

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/useresendrequest_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['request_amount'] = requestamount;
    request.fields['request_item'] = requestitem;
    request.fields['quantity'] = quantity;
    request.fields['category'] = selectedSubId.toString();
    request.fields['lid'] = lid!;
    request.fields['urgency_level'] = drop;

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Request submitted successfully.");
        Navigator.push(context, MaterialPageRoute(builder: (context) => userhome()));
      } else {
        Fluttertoast.showToast(msg: "Submission failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => userhome()));
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
            widget.title.isNotEmpty ? widget.title : 'Send Request',
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
                          Icons.request_page,
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
                              'Create New Request',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textBrown,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Fill in the details below',
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

                // Request Amount Field
                _buildSectionHeader('Request Details', Icons.receipt_outlined),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _requestamounttextController,
                  label: 'Request Amount',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Amount is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Request Item Field
                _buildTextField(
                  controller: _requestitemtextController,
                  label: 'Request Item',
                  icon: Icons.shopping_bag_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Item is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Quantity Field
                _buildTextField(
                  controller: _quantitytextController,
                  label: 'Quantity',
                  icon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Quantity is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // Category Selection Section
                _buildSectionHeader('Category', Icons.category_outlined),
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
                    value: selectedSubName,
                    decoration: InputDecoration(
                      labelText: 'Select Category',
                      labelStyle: TextStyle(color: mediumPastelBrown),
                      prefixIcon: Icon(
                        Icons.category,
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    items: subNames.map((String dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(
                          dept,
                          style: TextStyle(color: textBrown),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubName = newValue;
                        selectedSubId = subIds[subNames.indexOf(newValue!)];
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please select a Category';
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Urgency Level Section
                _buildSectionHeader('Urgency Level', Icons.speed_outlined),
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
                    value: drop,
                    decoration: InputDecoration(
                      labelText: 'Select Urgency',
                      labelStyle: TextStyle(color: mediumPastelBrown),
                      prefixIcon: Icon(
                        Icons.speed,
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    items: urgency.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value == 'high'
                                    ? Colors.red
                                    : value == 'medium'
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              value.toUpperCase(),
                              style: TextStyle(
                                color: textBrown,
                                fontWeight: value == drop ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        drop = newvalue!;
                      });
                    },
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
                      "Submit Request",
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