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
// //       home: viewrating(title: 'View Users'),
// //     );
// //   }
// // }
// //
// // class viewrating extends StatefulWidget {
// //   const viewrating({super.key, required this.title});
// //   final String title;
// //
// //   @override
// //   State<viewrating> createState() => _viewratingState();
// // }
// //
// // class _viewratingState extends State<viewrating> {
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
// //       String apiUrl = '$urls/userviewratingstatus/';
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
//       home: viewrating(title: 'My Requests'),
//     );
//   }
// }
//
// class viewrating extends StatefulWidget {
//   const viewrating({super.key, required this.title});
//   final String title;
//
//   @override
//   State<viewrating> createState() => _viewratingState();
// }
//
// class _viewratingState extends State<viewrating> {
//   List<Map<String, dynamic>> requests = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewratings();
//   }
//
//   Future<void> viewratings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String baseUrl = sh.getString('url') ?? '';
//       String vid = sh.getString('vid') ?? '';
//
//       var response = await http.post(
//         Uri.parse('$baseUrl/viewvolunteerfeedback/'),
//         body: {'vid': vid},
//       );
//
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> temp = [];
//
//         for (var item in jsonData['data']) {
//           temp.add({
//             'rating': item['rating'],
//             'review': item['review'],
//             'date': item['date'],
//             'name': item['name'],
//             'email': item['email'],
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
//                     Text("rating: ${user['rating']}"),
//                     Text("review: ${user['review']}"),
//                     Text("date: ${user['date']}"),
//                     Text("name: ${user['name']}"),
//                     Text("email: ${user['email']}"),
//
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patel Brown Aesthetic',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: const Color(0xFF8B5A2B), // Warm brown
        scaffoldBackgroundColor: const Color(0xFFFDF8F2), // Cream background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6B4423), // Dark warm brown
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFF5E6D3), // Light cream
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.1,
          ),
          iconTheme: IconThemeData(color: Color(0xFFF5E6D3)),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFFFFF8F0), // Off-white cream
        ),
        fontFamily: 'Georgia', // Classic font for aesthetic look
      ),
      home: viewrating(title: 'My Requests'),
    );
  }
}

class viewrating extends StatefulWidget {
  const viewrating({super.key, required this.title});
  final String title;

  @override
  State<viewrating> createState() => _viewratingState();
}

class _viewratingState extends State<viewrating> {
  List<Map<String, dynamic>> requests = [];

  @override
  void initState() {
    super.initState();
    viewratings();
  }

  Future<void> viewratings() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? '';
      String vid = sh.getString('vid') ?? '';

      var response = await http.post(
        Uri.parse('$baseUrl/viewvolunteerfeedback/'),
        body: {'vid': vid},
      );

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> temp = [];

        for (var item in jsonData['data']) {
          temp.add({
            'rating': item['rating'],
            'review': item['review'],
            'date': item['date'],
            'name': item['name'],
            'email': item['email'],
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

  Widget _buildRatingStars(String rating) {
    int ratingValue = int.tryParse(rating) ?? 0;
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < ratingValue ? Icons.star : Icons.star_border,
          color: const Color(0xFFB78C5A), // Warm golden brown
          size: 18,
        );
      }),
    );
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
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w500,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B5A2B), // Warm brown
                  Color(0xFF6B4423), // Dark warm brown
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
                const Color(0xFFFDF8F2), // Cream
                const Color(0xFFF5E6D3), // Light cream brown
              ],
            ),
          ),
          child: requests.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.feedback_outlined,
                  size: 64,
                  color: const Color(0xFFB78C5A).withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  "No feedback yet",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF8B5A2B).withOpacity(0.7),
                    fontFamily: 'Georgia',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final user = requests[index];

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
                          Color(0xFFFFF8F0),
                          Color(0xFFF5EADD),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with name and rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                user['name'] ?? 'Anonymous',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4A2C1A),
                                  fontFamily: 'Georgia',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6D5B8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    user['rating'] ?? '0',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B4423),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFB78C5A),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Review text with quote decoration
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE6D5B8),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '"',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFFB78C5A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    user['review'] ?? 'No review provided',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF5A3E2B),
                                      fontFamily: 'Georgia',
                                      fontStyle: FontStyle.italic,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '"',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFFB78C5A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Footer with email and date
                        Container(
                          padding: const EdgeInsets.only(top: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFE6D5B8),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      size: 14,
                                      color: const Color(0xFF8B5A2B).withOpacity(0.7),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user['email'] ?? 'No email',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xFF8B5A2B).withOpacity(0.7),
                                          fontFamily: 'Georgia',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: const Color(0xFF8B5A2B).withOpacity(0.7),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user['date'] ?? 'No date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xFF8B5A2B).withOpacity(0.7),
                                      fontFamily: 'Georgia',
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}