// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // import '../chat.dart';
// // import 'home.dart';
// //
// //
// //
// // void main() {
// //   runApp(const ViewHouseApp());
// // }
// //
// // class ViewHouseApp extends StatelessWidget {
// //   const ViewHouseApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       home: Viewrequest(title: 'View Users'),
// //     );
// //   }
// // }
// //
// // class Viewrequest extends StatefulWidget {
// //   const Viewrequest({super.key, required this.title});
// //   final String title;
// //
// //   @override
// //   State<Viewrequest> createState() => _ViewrequestState();
// // }
// //
// // class _ViewrequestState extends State<Viewrequest> {
// //   List<Map<String, dynamic>> users = [];
// //   List<Map<String, dynamic>> filteredUsers = [];
// //   List<String> nameSuggestions = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewUsers("");
// //   }
// //
// //   Future<void> viewUsers(String searchValue) async {
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url') ?? '';
// //       String img = sh.getString('img_url') ?? '';
// //       String lid = sh.getString('lid') ?? '';
// //       String apiUrl = '$urls/userviewrequeststatus/';
// //
// //       var response = await http.post(Uri.parse(apiUrl), body: {
// //         'lid':lid
// //       });
// //       var jsonData = json.decode(response.body);
// //
// //       if (jsonData['status'] == 'ok') {
// //         List<Map<String, dynamic>> tempList = [];
// //         for (var item in jsonData['data']) {
// //           tempList.add({
// //             'id': item['id'],
// //             'request_amount': item['request_amount'],
// //             'request_item': item['request_item'],
// //             'quantity': item['quantity'],
// //             'status': item['status'],
// //             'urgency_level':item['urgency_level'],
// //             'request_date':item['request_date'],
// //             'category':item['category'],
// //             'volunteer_userid': item['volunteer_userid'],
// //             'volunteer_name': item['volunteer_name'],
// //           });
// //         }
// //         setState(() {
// //           users = tempList;
// //           filteredUsers = tempList
// //               .where((user) =>
// //               user['request_amount']
// //                   .toString()
// //                   .toLowerCase()
// //                   .contains(searchValue.toLowerCase()))
// //               .toList();
// //           nameSuggestions = users.map((e) => e['request_amount'].toString()).toSet().toList();
// //         });
// //       }
// //     } catch (e) {
// //       print("Error fetching users: $e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //         onWillPop: () async {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const userhome()),
// //       );
// //       return false; // Prevent default pop
// //     },
// //     child:Scaffold(
// //       // appBar: EasySearchBar(
// //       //   backgroundColor: Color.fromARGB(255, 232, 177, 61),
// //       //   title: Text('Search by name'),
// //       //   suggestions: nameSuggestions,
// //       //   onSearch: (value) {
// //       //     setState(() {
// //       //       filteredUsers = users
// //       //           .where((user) => user['name']
// //       //           .toString()
// //       //           .toLowerCase()
// //       //           .contains(value.toLowerCase()))
// //       //           .toList();
// //       //     });
// //       //   },
// //       // ),
// //       body: ListView.builder(
// //         shrinkWrap: true,
// //         physics: BouncingScrollPhysics(),
// //         itemCount: filteredUsers.length,
// //         itemBuilder: (context, index) {
// //           final user = filteredUsers[index];
// //           return Card(
// //             margin: const EdgeInsets.all(10),
// //             elevation: 5,
// //             child: ListTile(
// //               // leading: CircleAvatar(
// //               //   backgroundImage: NetworkImage(user['photo']),
// //               //   radius: 30,
// //               // ),
// //               // title: Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
// //               subtitle: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text("request_amount: ${user['request_amount']}"),
// //                   Text("request_item: ${user['request_item']}"),
// //                   Text("quantity: ${user['quantity']}"),
// //                   Text("urgency_level: ${user['urgency_level']}"),
// //                   Text("request_date: ${user['request_date']}"),
// //                   Text("category: ${user['category']}"),
// //                   Text("status: ${user['status']}"),
// //
// //
// //
// //
// //
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     ));
// //   }
// // }
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/user/usr_chat.dart';
//
// import 'home.dart';
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
//       debugShowCheckedModeBanner: false,
//       home: Viewrequest(title: 'My Requests'),
//     );
//   }
// }
//
// class Viewrequest extends StatefulWidget {
//   const Viewrequest({super.key, required this.title});
//   final String title;
//
//   @override
//   State<Viewrequest> createState() => _ViewrequestState();
// }
//
// class _ViewrequestState extends State<Viewrequest> {
//   List<Map<String, dynamic>> requests = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewRequests();
//   }
//
//   Future<void> viewRequests() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String baseUrl = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       var response = await http.post(
//         Uri.parse('$baseUrl/userviewrequeststatus/'),
//         body: {'lid': lid},
//       );
//
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> temp = [];
//
//         for (var item in jsonData['data']) {
//           temp.add({
//             'id': item['id'],
//             'request_amount': item['request_amount'],
//             'request_item': item['request_item'],
//             'quantity': item['quantity'],
//             'urgency_level': item['urgency_level'],
//             'request_date': item['request_date'],
//             'category': item['category'],
//             'status': item['status'],
//             'volunteer_userid': item['volunteer_userid'],
//             'volunteer_name': item['volunteer_name'],
//           });
//         }
//
//         setState(() {
//           requests = temp;
//         });
//       }
//     } catch (e) {
//       debugPrint("Error fetching requests: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userhome()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           backgroundColor: Colors.cyan,
//         ),
//         body: requests.isEmpty
//             ? const Center(child: Text("No requests found"))
//             : ListView.builder(
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final user = requests[index];
//
//             return Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Item: ${user['request_item']}"),
//                     Text("Amount: ${user['request_amount']}"),
//                     Text("Quantity: ${user['quantity']}"),
//                     Text("Urgency: ${user['urgency_level']}"),
//                     Text("Date: ${user['request_date']}"),
//                     Text("Category: ${user['category']}"),
//                     Text("Vuserid: ${user['volunteer_userid']}"),
//                     Text("V name : ${user['volunteer_name']}"),
//                     Text(
//                       "Status: ${user['status']}",
//                       style: TextStyle(
//                         color: user['status'] == 'approved'
//                             ? Colors.green
//                             : Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//
//                   if (
//               user['status'].toString().toLowerCase() == 'approved' &&
//                   user['volunteer_userid'] != null
//             )
//             ElevatedButton(
//               onPressed: () async {
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//
//                 sh.setString('toid', user['volunteer_userid'].toString());
//                 sh.setString('agrname', user['volunteer_name'].toString());
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MyChatPage(title: ''),
//                   ),
//                 );
//               },
//               child: const Text('Chat with Volunteer'),
//             )
//
//
//
//             ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/user/usr_chat.dart';
import 'home.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Viewrequest(title: 'My Requests'),
    );
  }
}

class Viewrequest extends StatefulWidget {
  const Viewrequest({super.key, required this.title});
  final String title;

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  List<Map<String, dynamic>> requests = [];

  @override
  void initState() {
    super.initState();
    viewRequests();
  }

  Future<void> viewRequests() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      var response = await http.post(
        Uri.parse('$baseUrl/userviewrequeststatus/'),
        body: {'lid': lid},
      );

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> temp = [];

        for (var item in jsonData['data']) {
          temp.add({
            'id': item['id'],
            'request_amount': item['request_amount'],
            'request_item': item['request_item'],
            'quantity': item['quantity'],
            'urgency_level': item['urgency_level'],
            'request_date': item['request_date'],
            'category': item['category'],
            'status': item['status'],
            'volunteer_userid': item['volunteer_userid'],
            'volunteer_name': item['volunteer_name'],
          });
        }

        setState(() {
          requests = temp;
        });
      }
    } catch (e) {
      debugPrint("Error fetching requests: $e");
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade700;
      case 'pending':
        return Colors.orange.shade700;
      case 'rejected':
        return Colors.red.shade700;
      default:
        return mediumPastelBrown;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.hourglass_empty;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help;
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
          MaterialPageRoute(builder: (context) => const userhome()),
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
              child: CircleAvatar(
                backgroundColor: darkPastelBrown.withOpacity(0.1),
                child: Icon(
                  Icons.notifications_none,
                  color: darkPastelBrown,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        body: requests.isEmpty
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
                'Your submitted requests will appear here',
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
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            final status = request['status'].toString();
            final urgency = request['urgency_level'].toString();
            final hasVolunteer = request['volunteer_userid'] != null &&
                request['volunteer_userid'].toString().isNotEmpty;

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
                  // Header with status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: darkPastelBrown.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.request_page,
                            color: darkPastelBrown,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            request['request_item'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textBrown,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon(status),
                                size: 14,
                                color: _getStatusColor(status),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(status),
                                ),
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
                        // Amount and Quantity Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.attach_money,
                                label: 'Amount',
                                value: request['request_amount'],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.numbers,
                                label: 'Quantity',
                                value: request['quantity'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Urgency and Date Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.speed,
                                label: 'Urgency',
                                value: urgency.toUpperCase(),
                                valueColor: _getUrgencyColor(urgency),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildInfoChip(
                                icon: Icons.calendar_today,
                                label: 'Date',
                                value: request['request_date'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Category
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: lightPastelBrown.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.category,
                                size: 16,
                                color: darkPastelBrown,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Category: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: mediumPastelBrown,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  request['category'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: textBrown,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Volunteer Info (if assigned)
                        if (hasVolunteer) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  lightPastelBrown.withOpacity(0.3),
                                  pastelBrown.withOpacity(0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.volunteer_activism,
                                    color: darkPastelBrown,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Assigned Volunteer',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: mediumPastelBrown,
                                        ),
                                      ),
                                      Text(
                                        request['volunteer_name'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: textBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Chat Button (if approved and volunteer assigned)
                        if (status.toLowerCase() == 'approved' && hasVolunteer) ...[
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  darkPastelBrown,
                                  mediumPastelBrown,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: darkPastelBrown.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences sh = await SharedPreferences.getInstance();
                                sh.setString('toid', request['volunteer_userid'].toString());
                                sh.setString('agrname', request['volunteer_name'].toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyChatPage(title: ''),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Chat with Volunteer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: lightPastelBrown.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: darkPastelBrown,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: mediumPastelBrown,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? textBrown,
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
}