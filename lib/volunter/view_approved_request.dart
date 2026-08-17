// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/volunter/volchat.dart';
// import 'package:socialcare/volunter/volunteerhome.dart';
//
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
//       home: viewapprovedrequest(title: 'View Users'),
//     );
//   }
// }
//
// class viewapprovedrequest extends StatefulWidget {
//   const viewapprovedrequest({super.key, required this.title});
//   final String title;
//
//   @override
//   State<viewapprovedrequest> createState() => _viewapprovedrequestState();
// }
//
// class _viewapprovedrequestState extends State<viewapprovedrequest> {
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
//       String apiUrl = '$urls/volunteerviewapprovedrequest/';
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
//                   ElevatedButton(
//                       onPressed: () async {
//
//                         SharedPreferences sh=await SharedPreferences.getInstance();
//                         sh.setString('toid', user['userid'].toString());
//                         sh.setString('agrname', user['username'].toString());
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Vol_ChatPage(title: '',)));
//                       },
//                       child:Text('chat'))
//
//
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
import 'package:socialcare/volunter/volchat.dart';
import 'package:socialcare/volunter/volunteerhome.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pastel Brown Aesthetic',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: const Color(0xFFD9B382), // Pastel brown
        scaffoldBackgroundColor: const Color(0xFFFDF3E4), // Soft cream
        appBarTheme: const AppBarTheme(
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFFDF8F2), // Cream white
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            fontFamily: 'Georgia',
          ),
          iconTheme: IconThemeData(color: Color(0xFFFDF8F2)),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFFFFF8F0), // Cream
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD9B382), // Pastel brown
            foregroundColor: const Color(0xFFFDF8F2), // Cream white
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        fontFamily: 'Georgia',
      ),
      home: viewapprovedrequest(title: 'Approved Requests'),
    );
  }
}

class viewapprovedrequest extends StatefulWidget {
  const viewapprovedrequest({super.key, required this.title});
  final String title;

  @override
  State<viewapprovedrequest> createState() => _viewapprovedrequestState();
}

class _viewapprovedrequestState extends State<viewapprovedrequest> {
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
      String lid = sh.getString('lid') ?? '';
      String apiUrl = '$urls/volunteerviewapprovedrequest/';

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
              user['request_amount']
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
              .toList();
          nameSuggestions = users.map((e) => e['request_amount'].toString()).toSet().toList();
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // Helper method to get urgency level color
  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'high':
        return const Color(0xFFE8A5A5); // Soft red
      case 'medium':
        return const Color(0xFFE8D5B5); // Light pastel tan
      case 'low':
        return const Color(0xFFC4E8C4); // Soft green
      default:
        return const Color(0xFFE8D5B5); // Light pastel tan
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
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w400,
            ),
          ),
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
        ),
        body: Container(
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
          child: filteredUsers.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: const Color(0xFFD9B382).withOpacity(0.5), // Pastel brown
                ),
                const SizedBox(height: 16),
                Text(
                  "No approved requests found",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                    fontFamily: 'Georgia',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFF8F0), // Cream
                          Color(0xFFF5EADD), // Light cream brown
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with user info and urgency
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User avatar with initials
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD9B382), // Pastel brown
                                    Color(0xFFC4A484), // Slightly darker
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  user['username']?.substring(0, 1).toUpperCase() ?? 'U',
                                  style: const TextStyle(
                                    color: Color(0xFFFDF8F2), // Cream white
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Georgia',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // User name and request info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['username'] ?? 'Unknown User',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4A2C1A), // Dark brown
                                      fontFamily: 'Georgia',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getUrgencyColor(user['urgency_level'] ?? 'medium'),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Urgency: ${user['urgency_level'] ?? 'N/A'}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF5C3E2E), // Dark brown text
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Status badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC4E8C4), // Soft green
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Approved',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF2E5C2E), // Dark green
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Request details section
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8D5B5).withOpacity(0.2), // Light pastel tan
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE8D5B5), // Light pastel tan
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                icon: Icons.shopping_bag_outlined,
                                label: 'Request Item:',
                                value: user['request_item'] ?? 'N/A',
                              ),
                              const Divider(color: Color(0xFFE8D5B5), height: 12),
                              _buildInfoRow(
                                icon: Icons.monetization_on_outlined,
                                label: 'Amount:',
                                value: '₹${user['request_amount'] ?? '0'}',
                              ),
                              const Divider(color: Color(0xFFE8D5B5), height: 12),
                              _buildInfoRow(
                                icon: Icons.numbers_outlined,
                                label: 'Quantity:',
                                value: user['quantity'] ?? 'N/A',
                              ),
                              const Divider(color: Color(0xFFE8D5B5), height: 12),
                              _buildInfoRow(
                                icon: Icons.category_outlined,
                                label: 'Category:',
                                value: '${user['parent_category'] ?? ''} > ${user['category_name'] ?? ''}',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Date and contact section
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      user['request_date'] ?? 'No date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                                        fontFamily: 'Georgia',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8D5B5), // Light pastel tan
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_outlined,
                                    size: 12,
                                    color: Color(0xFF8B6B4D), // Muted brown
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user['userphonenumber'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF8B6B4D), // Muted brown
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Email and chat button row
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    size: 14,
                                    color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      user['useremail'] ?? 'No email',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: const Color(0xFF8B6B4D).withOpacity(0.7), // Muted brown
                                        fontFamily: 'Georgia',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Chat button
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD9B382), // Pastel brown
                                    Color(0xFFC4A484), // Slightly darker
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD9B382).withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences sh = await SharedPreferences.getInstance();
                                  sh.setString('toid', user['userid'].toString());
                                  sh.setString('agrname', user['username'].toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Vol_ChatPage(title: '')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: const Color(0xFFFDF8F2), // Cream white
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  minimumSize: const Size(0, 36),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.chat_bubble_outline, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Georgia',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Status text (commented out as we already have a badge)
                        // Text("status: ${user['status']}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFFD9B382), // Pastel brown
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF8B6B4D), // Muted brown
                fontWeight: FontWeight.w500,
                fontFamily: 'Georgia',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5C3E2E), // Dark brown
                fontWeight: FontWeight.w500,
                fontFamily: 'Georgia',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
