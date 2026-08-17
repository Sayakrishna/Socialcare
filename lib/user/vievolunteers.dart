// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:socialcare/user/sendfeedback.dart';
// // import 'package:socialcare/user/viewrating.dart';
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
// //       home: viewvolunteer(title: 'View Users'),
// //     );
// //   }
// // }
// //
// // class viewvolunteer extends StatefulWidget {
// //   const viewvolunteer({super.key, required this.title});
// //   final String title;
// //
// //   @override
// //   State<viewvolunteer> createState() => _viewvolunteerState();
// // }
// //
// // class _viewvolunteerState extends State<viewvolunteer> {
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
// //       String apiUrl = '$urls/viewvolunteer/';
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
// //             'skills': item['skills'],
// //             'avilability': item['avilability'],
// //             'assigned_area': item['assigned_area'],
// //             'status': item['status'],
// //             'acceptedornot_status':item['acceptedornot_status'],
// //             'review':item['review'],
// //             'rating':item['rating'],
// //
// //
// //
// //
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
// //
// //
// //                   Text("skills: ${user['skills']}"),
// //                   Text("avilability: ${user['avilability']}"),
// //                   Text("assigned_area: ${user['assigned_area']}"),
// //                   Text("status: ${user['status']}"),
// //                   Text("acceptedornot_status: ${user['acceptedornot_status']}"),
// //                   Text("rating: ${user['rating']}"),
// //                   Text("review: ${user['review']}"),
// //
// //
// //                   ElevatedButton(onPressed: () async {
// //                     SharedPreferences sh=await SharedPreferences.getInstance();
// //                     sh.setString('vid', user['id'].toString());
// //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SendFeedback(title: '',)));
// //
// //                   }, child:Text('rate')),
// //
// //                   ElevatedButton(onPressed: () async {
// //                     SharedPreferences sh=await SharedPreferences.getInstance();
// //                     sh.setString('vid', user['id'].toString());
// //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>viewrating(title: '',)));
// //
// //                   }, child:Text('viewrate'))
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
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/user/sendfeedback.dart';
// import 'package:socialcare/user/viewrating.dart';
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
//       home: viewvolunteer(title: 'Volunteers'),
//     );
//   }
// }
//
// class viewvolunteer extends StatefulWidget {
//   const viewvolunteer({super.key, required this.title});
//   final String title;
//
//   @override
//   State<viewvolunteer> createState() => _viewvolunteerState();
// }
//
// class _viewvolunteerState extends State<viewvolunteer> {
//   // Pastel brown color palette
//   final Color pastelBrown = const Color(0xFFD7C0AE);
//   final Color lightPastelBrown = const Color(0xFFEAD7C3);
//   final Color mediumPastelBrown = const Color(0xFFB7A99A);
//   final Color darkPastelBrown = const Color(0xFF967E76);
//   final Color warmBackground = const Color(0xFFF9F5F0);
//   final Color textBrown = const Color(0xFF5C4E3D);
//
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
//       String apiUrl = '$urls/viewvolunteer/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid': lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'],
//             'skills': item['skills'],
//             'avilability': item['avilability'],
//             'assigned_area': item['assigned_area'],
//             'status': item['status'],
//             'acceptedornot_status': item['acceptedornot_status'],
//             'review': item['review'],
//             'rating': item['rating'],
//           });
//         }
//         setState(() {
//           users = tempList;
//           filteredUsers = tempList
//               .where((user) =>
//               user['skills']
//                   .toString()
//                   .toLowerCase()
//                   .contains(searchValue.toLowerCase()))
//               .toList();
//           nameSuggestions = users.map((e) => e['skills'].toString()).toSet().toList();
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return Colors.green.shade700;
//       case 'inactive':
//         return Colors.grey.shade600;
//       case 'busy':
//         return Colors.orange.shade700;
//       default:
//         return mediumPastelBrown;
//     }
//   }
//
//   String _getAvailabilityText(String availability) {
//     switch (availability.toLowerCase()) {
//       case 'available':
//         return 'Available Now';
//       case 'unavailable':
//         return 'Not Available';
//       case 'limited':
//         return 'Limited Availability';
//       default:
//         return availability;
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
//         backgroundColor: warmBackground,
//         appBar: AppBar(
//           leading: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.arrow_back,
//               color: Color(0xFF967E76),
//             ),
//           ),
//           leadingWidth: 50,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   warmBackground,
//                   lightPastelBrown,
//                 ],
//               ),
//             ),
//           ),
//           title: Text(
//             widget.title,
//             style: const TextStyle(
//               color: Color(0xFF5C4E3D),
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//           centerTitle: true,
//           actions: [
//             Container(
//               margin: const EdgeInsets.only(right: 16),
//               decoration: BoxDecoration(
//                 color: darkPastelBrown.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.search,
//                   color: darkPastelBrown,
//                 ),
//                 onPressed: () {
//                   // Implement search functionality
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: filteredUsers.isEmpty
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: lightPastelBrown.withOpacity(0.3),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.volunteer_activism,
//                   size: 60,
//                   color: mediumPastelBrown,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'No Volunteers Found',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: textBrown,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Check back later for available volunteers',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: mediumPastelBrown,
//                 ),
//               ),
//             ],
//           ),
//         )
//             : ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: filteredUsers.length,
//           itemBuilder: (context, index) {
//             final user = filteredUsers[index];
//             final status = user['status'].toString();
//             final availability = user['avilability'].toString();
//             final rating = double.tryParse(user['rating'].toString()) ?? 0.0;
//             final hasRating = rating > 0;
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: darkPastelBrown.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Header with volunteer info
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: lightPastelBrown.withOpacity(0.3),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 darkPastelBrown,
//                                 mediumPastelBrown,
//                               ],
//                             ),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Center(
//                             child: Text(
//                               'V${index + 1}',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: _getStatusColor(status).withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           Icons.circle,
//                                           size: 8,
//                                           color: _getStatusColor(status),
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           status.toUpperCase(),
//                                           style: TextStyle(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.bold,
//                                             color: _getStatusColor(status),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   if (hasRating)
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           size: 14,
//                                           color: Colors.amber.shade600,
//                                         ),
//                                         const SizedBox(width: 2),
//                                         Text(
//                                           rating.toStringAsFixed(1),
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w600,
//                                             color: textBrown,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Details Section
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         // Skills
//                         _buildDetailRow(
//                           icon: Icons.handyman,
//                           label: 'Skills',
//                           value: user['skills'],
//                         ),
//                         const SizedBox(height: 12),
//
//                         // Availability
//                         _buildDetailRow(
//                           icon: Icons.access_time,
//                           label: 'Availability',
//                           value: _getAvailabilityText(availability),
//                           valueColor: availability.toLowerCase() == 'available'
//                               ? Colors.green.shade700
//                               : availability.toLowerCase() == 'limited'
//                               ? Colors.orange.shade700
//                               : mediumPastelBrown,
//                         ),
//                         const SizedBox(height: 12),
//
//                         // Assigned Area
//                         _buildDetailRow(
//                           icon: Icons.location_on,
//                           label: 'Assigned Area',
//                           value: user['assigned_area'],
//                         ),
//                         const SizedBox(height: 12),
//
//                         // Accepted Status
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: lightPastelBrown.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 size: 16,
//                                 color: darkPastelBrown,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'Status: ',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: mediumPastelBrown,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   user['acceptedornot_status'] == '1'
//                                       ? 'Accepted'
//                                       : 'Pending',
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: user['acceptedornot_status'] == '1'
//                                         ? Colors.green.shade700
//                                         : Colors.orange.shade700,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Review (if exists)
//                         if (user['review'] != null && user['review'].toString().isNotEmpty) ...[
//                           const SizedBox(height: 12),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: lightPastelBrown.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.comment,
//                                       size: 14,
//                                       color: darkPastelBrown,
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       'Recent Review',
//                                       style: TextStyle(
//                                         fontSize: 11,
//                                         color: mediumPastelBrown,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   user['review'],
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     color: textBrown,
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//
//                         const SizedBox(height: 16),
//
//                         // Action Buttons
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildActionButton(
//                                 label: 'Rate',
//                                 icon: Icons.star_border,
//                                 color: darkPastelBrown,
//                                 onPressed: () async {
//                                   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   sh.setString('vid', user['id'].toString());
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SendFeedback(title: ''),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: _buildActionButton(
//                                 label: 'View Ratings',
//                                 icon: Icons.rate_review,
//                                 color: mediumPastelBrown,
//                                 onPressed: () async {
//                                   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   sh.setString('vid', user['id'].toString());
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => viewrating(title: ''),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: lightPastelBrown.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 16,
//             color: darkPastelBrown,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontSize: 13,
//               color: mediumPastelBrown,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: valueColor ?? textBrown,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String label,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       height: 40,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             color,
//             color.withOpacity(0.8),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: EdgeInsets.zero,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: Colors.white,
//               size: 16,
//             ),
//             const SizedBox(width: 4),
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:socialcare/user/sendfeedback.dart';
// import 'package:socialcare/user/viewrating.dart';
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
//       home: viewvolunteer(title: 'Volunteers'),
//     );
//   }
// }
//
// class viewvolunteer extends StatefulWidget {
//   const viewvolunteer({super.key, required this.title});
//   final String title;
//
//   @override
//   State<viewvolunteer> createState() => _viewvolunteerState();
// }
//
// class _viewvolunteerState extends State<viewvolunteer> {
//   // Pastel brown color palette
//   final Color pastelBrown = const Color(0xFFD7C0AE);
//   final Color lightPastelBrown = const Color(0xFFEAD7C3);
//   final Color mediumPastelBrown = const Color(0xFFB7A99A);
//   final Color darkPastelBrown = const Color(0xFF967E76);
//   final Color warmBackground = const Color(0xFFF9F5F0);
//   final Color textBrown = const Color(0xFF5C4E3D);
//
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   List<String> nameSuggestions = [];
//
//   // Search controller
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers("");
//
//     // Add listener to search controller
//     _searchController.addListener(_filterUsers);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_filterUsers);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _filterUsers() {
//     setState(() {
//       _searchQuery = _searchController.text;
//       if (_searchQuery.isEmpty) {
//         filteredUsers = List.from(users);
//       } else {
//         filteredUsers = users
//             .where((user) =>
//         user['skills']
//             .toString()
//             .toLowerCase()
//             .contains(_searchQuery.toLowerCase()) ||
//             user['assigned_area']
//                 .toString()
//                 .toLowerCase()
//                 .contains(_searchQuery.toLowerCase()) ||
//             user['avilability']
//                 .toString()
//                 .toLowerCase()
//                 .contains(_searchQuery.toLowerCase()))
//             .toList();
//       }
//     });
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String img = sh.getString('img_url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String apiUrl = '$urls/viewvolunteer/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid': lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'name': item['name'].toString(),
//             'email': item['email'].toString(),
//             'skills': item['skills'],
//             'avilability': item['avilability'],
//             'assigned_area': item['assigned_area'],
//             'status': item['status'],
//             'acceptedornot_status': item['acceptedornot_status'],
//             'review': item['review'],
//             'rating': item['rating'],
//           });
//         }
//         setState(() {
//           users = tempList;
//           filteredUsers = List.from(tempList);
//           nameSuggestions = users.map((e) => e['skills'].toString()).toSet().toList();
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }
//
//   void _clearSearch() {
//     _searchController.clear();
//     FocusScope.of(context).unfocus();
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return Colors.green.shade700;
//       case 'inactive':
//         return Colors.grey.shade600;
//       case 'busy':
//         return Colors.orange.shade700;
//       default:
//         return mediumPastelBrown;
//     }
//   }
//
//   String _getAvailabilityText(String availability) {
//     switch (availability.toLowerCase()) {
//       case 'available':
//         return 'Available Now';
//       case 'unavailable':
//         return 'Not Available';
//       case 'limited':
//         return 'Limited Availability';
//       default:
//         return availability;
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
//         backgroundColor: warmBackground,
//         appBar: AppBar(
//           leading: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.arrow_back,
//               color: Color(0xFF967E76),
//             ),
//           ),
//           leadingWidth: 50,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   warmBackground,
//                   lightPastelBrown,
//                 ],
//               ),
//             ),
//           ),
//           title: Text(
//             widget.title,
//             style: const TextStyle(
//               color: Color(0xFF5C4E3D),
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             // Search Bar Section
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: darkPastelBrown.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: lightPastelBrown.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                     color: mediumPastelBrown.withOpacity(0.3),
//                   ),
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search by skills, area, or availability...',
//                     hintStyle: TextStyle(
//                       color: mediumPastelBrown,
//                       fontSize: 14,
//                     ),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: darkPastelBrown,
//                       size: 20,
//                     ),
//                     suffixIcon: _searchQuery.isNotEmpty
//                         ? IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: darkPastelBrown,
//                         size: 18,
//                       ),
//                       onPressed: _clearSearch,
//                     )
//                         : null,
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                   ),
//                   style: TextStyle(
//                     color: textBrown,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//
//             // Search Results Count
//             if (_searchQuery.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   '${filteredUsers.length} result${filteredUsers.length != 1 ? 's' : ''} found',
//                   style: TextStyle(
//                     color: darkPastelBrown,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//             // Volunteers List
//             Expanded(
//               child: filteredUsers.isEmpty
//                   ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: lightPastelBrown.withOpacity(0.3),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.search_off,
//                         size: 60,
//                         color: mediumPastelBrown,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       _searchQuery.isEmpty
//                           ? 'No Volunteers Found'
//                           : 'No matching volunteers',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: textBrown,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       _searchQuery.isEmpty
//                           ? 'Check back later for available volunteers'
//                           : 'Try different search terms',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: mediumPastelBrown,
//                       ),
//                     ),
//                     if (_searchQuery.isNotEmpty)
//                       TextButton(
//                         onPressed: _clearSearch,
//                         child: Text(
//                           'Clear Search',
//                           style: TextStyle(
//                             color: darkPastelBrown,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               )
//                   : ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: filteredUsers.length,
//                 itemBuilder: (context, index) {
//                   final user = filteredUsers[index];
//                   final status = user['status'].toString();
//                   final availability = user['avilability'].toString();
//                   final rating = double.tryParse(user['rating'].toString()) ?? 0.0;
//                   final hasRating = rating > 0;
//
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: darkPastelBrown.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         // Header with volunteer info
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: lightPastelBrown.withOpacity(0.3),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 50,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       darkPastelBrown,
//                                       mediumPastelBrown,
//                                     ],
//                                   ),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'V${index + 1}',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: _getStatusColor(status).withOpacity(0.1),
//                                             borderRadius: BorderRadius.circular(12),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Icon(
//                                                 Icons.circle,
//                                                 size: 8,
//                                                 color: _getStatusColor(status),
//                                               ),
//                                               const SizedBox(width: 4),
//                                               Text(
//                                                 status.toUpperCase(),
//                                                 style: TextStyle(
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: _getStatusColor(status),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         if (hasRating)
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 14,
//                                                 color: Colors.amber.shade600,
//                                               ),
//                                               const SizedBox(width: 2),
//                                               Text(
//                                                 rating.toStringAsFixed(1),
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w600,
//                                                   color: textBrown,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Details Section
//                         Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             children: [
//                               // Skills
//                               _buildDetailRow(
//                                 icon: Icons.person,
//                                 label: 'Name',
//                                 value: user['name'],
//                               ),
//                               const SizedBox(height: 12),
//                               _buildDetailRow(
//                                 icon: Icons.email,
//                                 label: 'Email',
//                                 value: user['email'],
//                               ),
//                               const SizedBox(height: 12),
//                               _buildDetailRow(
//                                 icon: Icons.handyman,
//                                 label: 'Skills',
//                                 value: user['skills'],
//                               ),
//                               const SizedBox(height: 12),
//
//                               // Availability
//                               _buildDetailRow(
//                                 icon: Icons.access_time,
//                                 label: 'Availability',
//                                 value: _getAvailabilityText(availability),
//                                 valueColor: availability.toLowerCase() == 'available'
//                                     ? Colors.green.shade700
//                                     : availability.toLowerCase() == 'limited'
//                                     ? Colors.orange.shade700
//                                     : mediumPastelBrown,
//                               ),
//                               const SizedBox(height: 12),
//
//                               // Assigned Area
//                               _buildDetailRow(
//                                 icon: Icons.location_on,
//                                 label: 'Assigned Area',
//                                 value: user['assigned_area'],
//                               ),
//                               const SizedBox(height: 12),
//
//                               // Accepted Status
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: lightPastelBrown.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.check_circle_outline,
//                                       size: 16,
//                                       color: darkPastelBrown,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       'Status: ',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: mediumPastelBrown,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         user['acceptedornot_status'] == '1'
//                                             ? 'Accepted'
//                                             : 'Pending',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: user['acceptedornot_status'] == '1'
//                                               ? Colors.green.shade700
//                                               : Colors.orange.shade700,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               // Review (if exists)
//                               if (user['review'] != null && user['review'].toString().isNotEmpty) ...[
//                                 const SizedBox(height: 12),
//                                 Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: lightPastelBrown.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.comment,
//                                             size: 14,
//                                             color: darkPastelBrown,
//                                           ),
//                                           const SizedBox(width: 6),
//                                           Text(
//                                             'Recent Review',
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: mediumPastelBrown,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 6),
//                                       Text(
//                                         user['review'],
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: textBrown,
//                                           fontStyle: FontStyle.italic,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//
//                               const SizedBox(height: 16),
//
//                               // Action Buttons
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: _buildActionButton(
//                                       label: 'Rate',
//                                       icon: Icons.star_border,
//                                       color: darkPastelBrown,
//                                       onPressed: () async {
//                                         SharedPreferences sh = await SharedPreferences.getInstance();
//                                         sh.setString('vid', user['id'].toString());
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => SendFeedback(title: ''),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: _buildActionButton(
//                                       label: 'View Ratings',
//                                       icon: Icons.rate_review,
//                                       color: mediumPastelBrown,
//                                       onPressed: () async {
//                                         SharedPreferences sh = await SharedPreferences.getInstance();
//                                         sh.setString('vid', user['id'].toString());
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => viewrating(title: ''),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: lightPastelBrown.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 16,
//             color: darkPastelBrown,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontSize: 13,
//               color: mediumPastelBrown,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: valueColor ?? textBrown,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String label,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       height: 40,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             color,
//             color.withOpacity(0.8),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: EdgeInsets.zero,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: Colors.white,
//               size: 16,
//             ),
//             const SizedBox(width: 4),
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socialcare/user/sendfeedback.dart';
import 'package:socialcare/user/viewrating.dart';
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
      home: viewvolunteer(title: 'Volunteers'),
    );
  }
}

class viewvolunteer extends StatefulWidget {
  const viewvolunteer({super.key, required this.title});
  final String title;

  @override
  State<viewvolunteer> createState() => _viewvolunteerState();
}

class _viewvolunteerState extends State<viewvolunteer> {
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

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Loading state
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    viewUsers("");

    // Add listener to search controller
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    setState(() {
      _searchQuery = _searchController.text;
      if (_searchQuery.isEmpty) {
        filteredUsers = List.from(users);
      } else {
        filteredUsers = users
            .where((user) =>
        user['skills']
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()) ||
            user['assigned_area']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user['avilability']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user['name']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> viewUsers(String searchValue) async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String apiUrl = '$urls/viewvolunteer/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'name': item['name']?.toString() ?? 'Unknown',
            'email': item['email']?.toString() ?? '',
            'skills': item['skills']?.toString() ?? '',
            'avilability': item['avilability']?.toString() ?? '',
            'assigned_area': item['assigned_area']?.toString() ?? '',
            'status': item['status']?.toString() ?? '',
            'acceptedornot_status': item['acceptedornot_status']?.toString() ?? '',

            // New review data fields
            'review': item['review']?.toString() ?? '',
            'rating': item['rating']?.toString() ?? '0',
            'total_reviews': item['total_reviews'] ?? 0,
            'positive_count': item['positive_count'] ?? 0,
            'neutral_count': item['neutral_count'] ?? 0,
            'negative_count': item['negative_count'] ?? 0,
            'positive_ratio': item['positive_ratio'] ?? 0,
            'avg_rating': item['avg_rating'] ?? 0,
            'primary_sentiment': item['primary_sentiment'] ?? 'Neutral',
            'sentiment_color': item['sentiment_color'] ?? '#ffc107',
            'quality_score': item['quality_score'] ?? 0,
            'rank': item['rank'] ?? 0,

            // Recent reviews (optional)
            'recent_reviews': item['reviews'] ?? [],
          });
        }

        setState(() {
          users = tempList;
          filteredUsers = List.from(tempList);
          _isLoading = false;

          // Update name suggestions for search
          nameSuggestions = users
              .map((e) => e['name'].toString())
              .where((name) => name.isNotEmpty)
              .toSet()
              .toList();
        });

        print("Loaded ${users.length} volunteers sorted by positive reviews");
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green.shade700;
      case 'inactive':
        return Colors.grey.shade600;
      case 'busy':
        return Colors.orange.shade700;
      default:
        return mediumPastelBrown;
    }
  }

  String _getAvailabilityText(String availability) {
    switch (availability.toLowerCase()) {
      case 'available':
        return 'Available Now';
      case 'unavailable':
        return 'Not Available';
      case 'limited':
        return 'Limited Availability';
      default:
        return availability;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return Colors.green.shade700;
      case 'negative':
        return Colors.red.shade700;
      case 'neutral':
        return Colors.orange.shade700;
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
            // Sort indicator
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: darkPastelBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.stars,
                    size: 16,
                    color: darkPastelBrown,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Top Rated',
                    style: TextStyle(
                      fontSize: 12,
                      color: darkPastelBrown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Search Bar Section
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: darkPastelBrown.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: lightPastelBrown.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: mediumPastelBrown.withOpacity(0.3),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name, skills, area...',
                    hintStyle: TextStyle(
                      color: mediumPastelBrown,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkPastelBrown,
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: darkPastelBrown,
                        size: 18,
                      ),
                      onPressed: _clearSearch,
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: TextStyle(
                    color: textBrown,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            // Search Results Count
            if (_searchQuery.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${filteredUsers.length} result${filteredUsers.length != 1 ? 's' : ''} found',
                  style: TextStyle(
                    color: darkPastelBrown,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            // Volunteers List
            Expanded(
              child: _isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(darkPastelBrown),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading volunteers...',
                      style: TextStyle(
                        color: textBrown,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
                  : filteredUsers.isEmpty
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
                        _searchQuery.isEmpty ? Icons.volunteer_activism : Icons.search_off,
                        size: 60,
                        color: mediumPastelBrown,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _searchQuery.isEmpty
                          ? 'No Volunteers Found'
                          : 'No matching volunteers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textBrown,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _searchQuery.isEmpty
                          ? 'Check back later for available volunteers'
                          : 'Try different search terms',
                      style: TextStyle(
                        fontSize: 14,
                        color: mediumPastelBrown,
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      TextButton(
                        onPressed: _clearSearch,
                        child: Text(
                          'Clear Search',
                          style: TextStyle(
                            color: darkPastelBrown,
                            fontWeight: FontWeight.w600,
                          ),
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
                  final status = user['status'].toString();
                  final availability = user['avilability'].toString();

                  // Parse review data
                  final avgRating = (user['avg_rating'] as num?)?.toDouble() ?? 0.0;
                  final totalReviews = user['total_reviews'] as int? ?? 0;
                  final positiveCount = user['positive_count'] as int? ?? 0;
                  final neutralCount = user['neutral_count'] as int? ?? 0;
                  final negativeCount = user['negative_count'] as int? ?? 0;
                  final primarySentiment = user['primary_sentiment'].toString();
                  final rank = user['rank'] as int? ?? 0;

                  // Calculate percentages
                  final positivePercent = totalReviews > 0
                      ? (positiveCount / totalReviews * 100).toInt()
                      : 0;
                  final neutralPercent = totalReviews > 0
                      ? (neutralCount / totalReviews * 100).toInt()
                      : 0;
                  final negativePercent = totalReviews > 0
                      ? (negativeCount / totalReviews * 100).toInt()
                      : 0;

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
                        // Header with volunteer info and rank
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
                              // Rank badge
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: rank <= 3
                                      ? LinearGradient(
                                    colors: [
                                      Colors.amber.shade700,
                                      Colors.amber.shade400,
                                    ],
                                  )
                                      : LinearGradient(
                                    colors: [
                                      darkPastelBrown,
                                      mediumPastelBrown,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    rank > 0 ? '#$rank' : 'V',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Volunteer name and status
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name'],
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
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(status).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                                color: _getStatusColor(status),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                status.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: _getStatusColor(status),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (avgRating > 0)
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: Colors.amber.shade600,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                avgRating.toStringAsFixed(1),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: textBrown,
                                                ),
                                              ),
                                              Text(
                                                ' ($totalReviews)',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: mediumPastelBrown,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Details Section
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Review Summary Section
                              if (totalReviews > 0) ...[
                                // Sentiment badges
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildSentimentBadge(
                                      label: 'Positive',
                                      count: positiveCount,
                                      color: Colors.green.shade700,
                                      percentage: positivePercent,
                                    ),
                                    _buildSentimentBadge(
                                      label: 'Neutral',
                                      count: neutralCount,
                                      color: Colors.orange.shade700,
                                      percentage: neutralPercent,
                                    ),
                                    _buildSentimentBadge(
                                      label: 'Negative',
                                      count: negativeCount,
                                      color: Colors.red.shade700,
                                      percentage: negativePercent,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Sentiment progress bar
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 8,
                                    child: Row(
                                      children: [
                                        if (positivePercent > 0)
                                          Expanded(
                                            flex: positivePercent,
                                            child: Container(
                                              color: Colors.green.shade600,
                                            ),
                                          ),
                                        if (neutralPercent > 0)
                                          Expanded(
                                            flex: neutralPercent,
                                            child: Container(
                                              color: Colors.orange.shade600,
                                            ),
                                          ),
                                        if (negativePercent > 0)
                                          Expanded(
                                            flex: negativePercent,
                                            child: Container(
                                              color: Colors.red.shade600,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],

                              // Name
                              _buildDetailRow(
                                icon: Icons.person,
                                label: 'Name',
                                value: user['name'],
                              ),
                              const SizedBox(height: 12),

                              // Email
                              _buildDetailRow(
                                icon: Icons.email,
                                label: 'Email',
                                value: user['email'],
                              ),
                              const SizedBox(height: 12),

                              // Skills
                              _buildDetailRow(
                                icon: Icons.handyman,
                                label: 'Skills',
                                value: user['skills'],
                              ),
                              const SizedBox(height: 12),

                              // Availability
                              _buildDetailRow(
                                icon: Icons.access_time,
                                label: 'Availability',
                                value: _getAvailabilityText(availability),
                                valueColor: availability.toLowerCase() == 'available'
                                    ? Colors.green.shade700
                                    : availability.toLowerCase() == 'limited'
                                    ? Colors.orange.shade700
                                    : mediumPastelBrown,
                              ),
                              const SizedBox(height: 12),

                              // Assigned Area
                              _buildDetailRow(
                                icon: Icons.location_on,
                                label: 'Assigned Area',
                                value: user['assigned_area'],
                              ),
                              const SizedBox(height: 12),

                              // Accepted Status
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
                                      Icons.check_circle_outline,
                                      size: 16,
                                      color: darkPastelBrown,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Status: ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: mediumPastelBrown,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user['acceptedornot_status'] == '1'
                                            ? 'Accepted'
                                            : 'Pending',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: user['acceptedornot_status'] == '1'
                                              ? Colors.green.shade700
                                              : Colors.orange.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Latest Review (if exists)
                              if (user['review'] != null &&
                                  user['review'].toString().isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _getSentimentColor(primarySentiment).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _getSentimentColor(primarySentiment).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.comment,
                                            size: 14,
                                            color: _getSentimentColor(primarySentiment),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Latest Review',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: mediumPastelBrown,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getSentimentColor(primarySentiment),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              primarySentiment,
                                              style: const TextStyle(
                                                fontSize: 8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        user['review'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: textBrown,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (user['rating'] != null &&
                                          user['rating'].toString().isNotEmpty &&
                                          user['rating'].toString() != '0')
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 12,
                                                color: Colors.amber.shade600,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Rating: ${user['rating']}/5',
                                                style: TextStyle(
                                                  fontSize: 11,
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

                              const SizedBox(height: 16),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(
                                      label: 'Rate',
                                      icon: Icons.star_border,
                                      color: darkPastelBrown,
                                      onPressed: () async {
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        sh.setString('vid', user['id'].toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SendFeedback(title: ''),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildActionButton(
                                      label: 'View Ratings',
                                      icon: Icons.rate_review,
                                      color: mediumPastelBrown,
                                      onPressed: () async {
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        sh.setString('vid', user['id'].toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => viewrating(title: ''),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentimentBadge({
    required String label,
    required int count,
    required Color color,
    required int percentage,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: mediumPastelBrown,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 9,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
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
          Icon(
            icon,
            size: 16,
            color: darkPastelBrown,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              color: mediumPastelBrown,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? textBrown,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
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
            color: color.withOpacity(0.2),
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
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
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