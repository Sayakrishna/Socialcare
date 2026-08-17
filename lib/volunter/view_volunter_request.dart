// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/volunter/volunteerhome.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart';
//
// import '../user/home.dart';
//
//
//
//
// void main() {
//   runApp(const ViewHouseApp());
// }
//
// class ViewHouseApp extends StatelessWidget {
//   const ViewHouseApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: viewvolunteerrequest(title: 'View Users'),
//     );
//   }
// }
//
// class viewvolunteerrequest extends StatefulWidget {
//   const viewvolunteerrequest({super.key, required this.title});
//   final String title;
//
//   @override
//   State<viewvolunteerrequest> createState() => _viewvolunteerrequestState();
// }
//
// class _viewvolunteerrequestState extends State<viewvolunteerrequest> {
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   List<String> nameSuggestions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers("");
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String img = sh.getString('img_url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String apiUrl = '$urls/volunteerviewdonationrequest/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid':lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'],
//             'userid': item['userid'],
//             'request_amount': item['request_amount'],
//             'request_item': item['request_item'],
//             'quantity': item['quantity'],
//             'status': item['status'],
//             'urgency_level':item['urgency_level'],
//             'request_date':item['request_date'],
//             'username':item['username'],
//             'useremail':item['useremail'],
//             'userphonenumber':item['userphonenumber'],
//             'parent_category':item['parent_category'],
//             'category_name':item['category_name'],
//           });
//
//
//
//     }
//         setState(() {
//           users = tempList;
//           filteredUsers = tempList
//               .where((user) =>
//               user['request_amount']
//                   .toString()
//                   .toLowerCase()
//                   .contains(searchValue.toLowerCase()))
//               .toList();
//           nameSuggestions = users.map((e) => e['request_amount'].toString()).toSet().toList();
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const volunteerhome()),
//       );
//       return false; // Prevent default pop
//     },
//     child:Scaffold(
//       // appBar: EasySearchBar(
//       //   backgroundColor: Color.fromARGB(255, 232, 177, 61),
//       //   title: Text('Search by name'),
//       //   suggestions: nameSuggestions,
//       //   onSearch: (value) {
//       //     setState(() {
//       //       filteredUsers = users
//       //           .where((user) => user['name']
//       //           .toString()
//       //           .toLowerCase()
//       //           .contains(value.toLowerCase()))
//       //           .toList();
//       //     });
//       //   },
//       // ),
//       body: ListView.builder(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemCount: filteredUsers.length,
//         itemBuilder: (context, index) {
//           final user = filteredUsers[index];
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 5,
//             child: ListTile(
//               // leading: CircleAvatar(
//               //   backgroundImage: NetworkImage(user['photo']),
//               //   radius: 30,
//               // ),
//               // title: Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("request_amount: ${user['request_amount']}"),
//                   Text("request_item: ${user['request_item']}"),
//                   Text("quantity: ${user['quantity']}"),
//                   Text("request_date: ${user['request_date']}"),
//                   Text("parent_category: ${user['parent_category']}"),
//                   Text("category_name: ${user['category_name']}"),
//                   Text("useremail: ${user['useremail']}"),
//                   Text("userphonenumber: ${user['userphonenumber']}"),
//                   Text("urgency_level: ${user['urgency_level']}"),
//                   Text("username: ${user['username']}"),
//                   Text("status: ${user['status']}"),
//
//
//                   if (user['status'] =='pending')...{
//
//
//                     ElevatedButton(
//                         onPressed: () async {
//                           SharedPreferences sh = await SharedPreferences.getInstance();
//                           String? url = sh.getString('url');
//                           String? lid = sh.getString('lid');
//
//
//                           if (url == null) {
//                             Fluttertoast.showToast(msg: "Server URL not found.");
//                             return;
//                           }
//
//                           final uri = Uri.parse('$url/volunteerapproverequest/');
//                           var request = http.MultipartRequest('POST', uri);
//                           request.fields['rid'] = user['id'].toString();
//                           request.fields['lid'] = lid.toString();
//
//
//
//                           try {
//                             var response = await request.send();
//                             var respStr = await response.stream.bytesToString();
//                             var data = jsonDecode(respStr);
//
//                             if (response.statusCode == 200 && data['status'] == 'ok') {
//                               Fluttertoast.showToast(msg: "Submitted successfully.");
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>volunteerhome()));
//
//                             } else {
//                               Fluttertoast.showToast(msg: "Submission failed.");
//                             }
//                           } catch (e) {
//                             Fluttertoast.showToast(msg: "Error: $e");
//                           }
//                         },
//                         child: Text('approve')
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           SharedPreferences sh = await SharedPreferences.getInstance();
//                           String? url = sh.getString('url');
//                           String? lid = sh.getString('lid');
//
//                           if (url == null) {
//                             Fluttertoast.showToast(msg: "Server URL not found.");
//                             return;
//                           }
//
//                           final uri = Uri.parse('$url/volunteerrejectrequest/');
//                           var request = http.MultipartRequest('POST', uri);
//
//                           request.fields['rid'] = user['id'].toString();
//                           request.fields['lid'] = lid.toString();
//
//
//
//
//                           try {
//                             var response = await request.send();
//                             var respStr = await response.stream.bytesToString();
//                             var data = jsonDecode(respStr);
//
//                             if (response.statusCode == 200 && data['status'] == 'ok') {
//                               Fluttertoast.showToast(msg: "Submitted successfully.");
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>volunteerhome()));
//
//                             } else {
//                               Fluttertoast.showToast(msg: "Submission failed.");
//                             }
//                           } catch (e) {
//                             Fluttertoast.showToast(msg: "Error: $e");
//                           }
//                         },
//                         child: Text('reject')
//                     ),
//
//                   }
//
//
//
//                 ],
//
//               ),
//             ),
//           );
//         },
//       ),
//     ));
//   }
// }






import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/volunter/volunteerhome.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: viewvolunteerrequest(title: 'Donation Requests'),
    );
  }
}

class viewvolunteerrequest extends StatefulWidget {
  const viewvolunteerrequest({super.key, required this.title});
  final String title;

  @override
  State<viewvolunteerrequest> createState() => _viewvolunteerrequestState();
}

class _viewvolunteerrequestState extends State<viewvolunteerrequest> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  List<String> nameSuggestions = [];

  @override
  void initState() {
    super.initState();
    viewUsers("");
  }

  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String img = sh.getString('img_url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String apiUrl = '$urls/volunteerviewdonationrequest/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'userid': item['userid'],
            'request_amount': item['request_amount'],
            'request_item': item['request_item'],
            'quantity': item['quantity'],
            'status': item['status'],
            'urgency_level': item['urgency_level'],
            'request_date': item['request_date'],
            'username': item['username'],
            'useremail': item['useremail'],
            'userphonenumber': item['userphonenumber'],
            'parent_category': item['parent_category'],
            'category_name': item['category_name'],
          });
        }
        setState(() {
          users = tempList;
          filteredUsers = tempList
              .where((user) =>
              user['request_item']
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
              .toList();
          nameSuggestions = users.map((e) => e['request_item'].toString()).toSet().toList();
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'high':
        return Colors.red.shade400;
      case 'medium':
        return Colors.orange.shade400;
      case 'low':
        return Colors.green.shade400;
      default:
        return mediumPastelBrown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const volunteerhome()),
        );
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
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: darkPastelBrown.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: darkPastelBrown,
                ),
                onPressed: () {
                  // Implement search functionality
                },
              ),
            ),
          ],
        ),
        body: filteredUsers.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: lightPastelBrown.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inbox,
                  size: 60,
                  color: mediumPastelBrown,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No Requests Found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textBrown,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'New donation requests will appear here',
                style: TextStyle(
                  fontSize: 14,
                  color: mediumPastelBrown,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            final urgency = user['urgency_level'].toString();
            final status = user['status'].toString();

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkPastelBrown.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header with user info and urgency
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: lightPastelBrown.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                darkPastelBrown,
                                mediumPastelBrown,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              user['username']?.toString()[0].toUpperCase() ?? 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['username'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textBrown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getUrgencyColor(urgency).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _getUrgencyColor(urgency),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          urgency.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _getUrgencyColor(urgency),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: status.toLowerCase() == 'approved'
                                          ? Colors.green.shade50
                                          : status.toLowerCase() == 'rejected'
                                          ? Colors.red.shade50
                                          : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: status.toLowerCase() == 'approved'
                                            ? Colors.green.shade700
                                            : status.toLowerCase() == 'rejected'
                                            ? Colors.red.shade700
                                            : Colors.orange.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Request Details
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Item and Amount Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.shopping_bag,
                                label: 'Item',
                                value: user['request_item'],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.attach_money,
                                label: 'Amount',
                                value: user['request_amount'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Quantity and Date Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.numbers,
                                label: 'Quantity',
                                value: user['quantity'],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.calendar_today,
                                label: 'Date',
                                value: user['request_date'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Categories
                        _buildDetailRow(
                          icon: Icons.category,
                          label: 'Category',
                          value: '${user['parent_category']} - ${user['category_name']}',
                        ),
                        const SizedBox(height: 10),

                        // User Contact Info
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: lightPastelBrown.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildContactRow(
                                icon: Icons.email,
                                value: user['useremail'],
                              ),
                              const SizedBox(height: 8),
                              _buildContactRow(
                                icon: Icons.phone,
                                value: user['userphonenumber'],
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons (if pending)
                        if (status.toLowerCase() == 'pending') ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildActionButton(
                                  label: 'Approve',
                                  icon: Icons.check_circle,
                                  color: Colors.green.shade600,
                                  onPressed: () async {
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    String? url = sh.getString('url');
                                    String? lid = sh.getString('lid');

                                    if (url == null) {
                                      Fluttertoast.showToast(msg: "Server URL not found.");
                                      return;
                                    }

                                    final uri = Uri.parse('$url/volunteerapproverequest/');
                                    var request = http.MultipartRequest('POST', uri);
                                    request.fields['rid'] = user['id'].toString();
                                    request.fields['lid'] = lid.toString();

                                    try {
                                      var response = await request.send();
                                      var respStr = await response.stream.bytesToString();
                                      var data = jsonDecode(respStr);

                                      if (response.statusCode == 200 && data['status'] == 'ok') {
                                        Fluttertoast.showToast(msg: "Request approved successfully");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => volunteerhome()),
                                        );
                                      } else {
                                        Fluttertoast.showToast(msg: "Approval failed");
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: "Error: $e");
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildActionButton(
                                  label: 'Reject',
                                  icon: Icons.cancel,
                                  color: Colors.red.shade600,
                                  onPressed: () async {
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    String? url = sh.getString('url');
                                    String? lid = sh.getString('lid');

                                    if (url == null) {
                                      Fluttertoast.showToast(msg: "Server URL not found.");
                                      return;
                                    }

                                    final uri = Uri.parse('$url/volunteerrejectrequest/');
                                    var request = http.MultipartRequest('POST', uri);
                                    request.fields['rid'] = user['id'].toString();
                                    request.fields['lid'] = lid.toString();

                                    try {
                                      var response = await request.send();
                                      var respStr = await response.stream.bytesToString();
                                      var data = jsonDecode(respStr);

                                      if (response.statusCode == 200 && data['status'] == 'ok') {
                                        Fluttertoast.showToast(msg: "Request rejected");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => volunteerhome()),
                                        );
                                      } else {
                                        Fluttertoast.showToast(msg: "Rejection failed");
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: "Error: $e");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: lightPastelBrown.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: darkPastelBrown),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 9, color: mediumPastelBrown),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: textBrown,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: lightPastelBrown.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: darkPastelBrown),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(
                fontSize: 13,
                color: textBrown,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: darkPastelBrown),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: textBrown,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}