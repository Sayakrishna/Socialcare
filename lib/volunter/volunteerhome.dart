// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:socialcare/volunter/view_approved_request.dart';
// import 'package:socialcare/volunter/view_volunter_request.dart';
// import 'package:socialcare/volunter/volunteerviewprofile.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../main.dart';
// import '../user/changepassword.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: volunteerhome(),
//   ));
// }
//
//
//
// void callbackDispatcher(String message) {
//   FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
//   var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//   var settings = new InitializationSettings(android: android);
//   flip.initialize(settings);
//   _showNotificationWithDefaultSound(flip, message);
// }
//
// Future _showNotificationWithDefaultSound(
//     FlutterLocalNotificationsPlugin flip, String message) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       '1', 'notification',
//       importance: Importance.max, priority: Priority.high);
//   var platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flip.show(0, 'REMINDER', message, platformChannelSpecifics,
//       payload: 'Default_Sound');
// }
//
//
// class volunteerhome extends StatefulWidget {
//   const volunteerhome({super.key});
//
//   @override
//   State<volunteerhome> createState() => _volunteerhomeState();
// }
//
// class _volunteerhomeState extends State<volunteerhome> {
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     Timer.periodic(Duration(seconds: 5), (timer) {
//       // getNotifications();
//       getdata();
//     });
//   }
//   List<Map<String, dynamic>> users = [];
//
//   Future<void> getdata() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     try {
//       String url = sh.getString('url').toString();
//       final urls = Uri.parse('$url/volunteerviewrequestnotification/');
//       String nid = "0";
//       if (sh.containsKey("nid")==false) {
//
//       } else {
//         nid = sh.getString('nid').toString();
//       }
//
//       var datas = await http.post(urls, body: {'nid': nid, });
//       var jsondata = json.decode(datas.body);
//       String status = jsondata['status'];
//       print(status);
//       if (status == "ok") {
//         String nid = jsondata['nid'].toString();
//         String message = jsondata['message'].toString();
//         // String billdate = jsondata['billdate'].toString();
//         sh.setString('nid',nid);
//         // if(nid != sh.getString('nid').toString()){
//         callbackDispatcher(message);
//         // }
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // drawer: const Drawer(
//       //   child: DrawerContent(),
//       // ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         // actions: const [
//         //   Icon(Icons.notifications_none),
//         //   SizedBox(width: 16),
//         // ],
//       ),
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/user.jpg'),
//                   radius: 25,
//                 ),
//                 SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hi volunteer,',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'What do you want to do today?',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(''),
//                       SizedBox(height: 6),
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(''),
//                       SizedBox(height: 6),
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 25),
//             const Text(
//               'Quick Actions',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 children: [
//                   ActionCard(
//                     title: 'Profile',
//                     color: Colors.pinkAccent,
//                     icon: Icons.verified_user,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => volunteerviewprofile(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'Change Password',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => changepassword(title: '')),
//                       );
//                     },
//                   ),
//
//                   //
//                   // ActionCard(
//                   //   title: 'send request',
//                   //   color: Colors.deepPurple,
//                   //   icon: Icons.table_view_outlined,
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(builder: (context) => sendrequest(title: '')),
//                   //     );
//                   //   },
//                   // ),
//
//                   ActionCard(
//                     title: 'view request',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => viewvolunteerrequest(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'view approved request',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => viewapprovedrequest(title: '')),
//                       );
//                     },
//                   ),
//
//
//                   ActionCard(
//                     title: 'Logout',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => myloginpage(title: '')),
//                       // );
//                     },
//                   ),
//
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ActionCard extends StatelessWidget {
//   final String title;
//   final Color color;
//   final IconData icon;
//   final VoidCallback? onTap; // ADD this
//
//   const ActionCard({
//     super.key,
//     required this.title,
//     required this.color,
//     required this.icon,
//     this.onTap, // ADD this
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // USE this
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: color,
//               child: Icon(icon, color: Colors.white),
//             ),
//             const SizedBox(height: 10),
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // class DrawerContent extends StatefulWidget {
// //   const DrawerContent({super.key});
// //
// //   @override
// //   State<DrawerContent> createState() => _DrawerContentState();
// // }
//
// // class _DrawerContentState extends State<DrawerContent> {
// //   void showDrawerMessage(String message) {
// //     Navigator.pop(context); // Close drawer
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message)),
// //     );
// //   }
// //
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return ListView(
// //   //     padding: EdgeInsets.zero,
// //   //     children: [
// //   //       const DrawerHeader(
// //   //         decoration: BoxDecoration(color: Colors.blue),
// //   //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.dashboard),
// //   //         title: const Text('Dashboard'),
// //   //         onTap: () => showDrawerMessage('Dashboard selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.receipt),
// //   //         title: const Text('Add User'),
// //   //         onTap: () => showDrawerMessage('Bills selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.send),
// //   //         title: const Text('Transfers'),
// //   //         onTap: () => showDrawerMessage('Transfers selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.settings),
// //   //         title: const Text('Settings'),
// //   //         onTap: () => showDrawerMessage('Settings selected'),
// //   //       ),
// //   //     ],
// //   //   );
// //   // }
// // }



import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialcare/volunter/view_approved_request.dart';
import 'package:socialcare/volunter/view_volunter_request.dart';
import 'package:socialcare/volunter/volunteerviewprofile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'vchangepassword.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: volunteerhome(),
  ));
}

void callbackDispatcher(String message) {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var settings = InitializationSettings(android: android);
  flip.initialize(settings);
  _showNotificationWithDefaultSound(flip, message);
}

Future _showNotificationWithDefaultSound(
    FlutterLocalNotificationsPlugin flip, String message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1', 'notification',
      importance: Importance.max, priority: Priority.high);
  var platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(0, 'REMINDER', message, platformChannelSpecifics,
      payload: 'Default_Sound');
}

class volunteerhome extends StatefulWidget {
  const volunteerhome({super.key});

  @override
  State<volunteerhome> createState() => _volunteerhomeState();
}

class _volunteerhomeState extends State<volunteerhome> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      // getNotifications();
      getdata();
    });
  }

  List<Map<String, dynamic>> users = [];

  Future<void> getdata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String url = sh.getString('url').toString();
      final urls = Uri.parse('$url/volunteerviewrequestnotification/');
      String nid = "0";
      if (sh.containsKey("nid")==false) {

      } else {
        nid = sh.getString('nid').toString();
      }

      var datas = await http.post(urls, body: {'nid': nid, });
      var jsondata = json.decode(datas.body);
      String status = jsondata['status'];
      print(status);
      if (status == "ok") {
        String nid = jsondata['nid'].toString();
        String message = jsondata['message'].toString();
        // String billdate = jsondata['billdate'].toString();
        sh.setString('nid',nid);
        // if(nid != sh.getString('nid').toString()){
        callbackDispatcher(message);
        // }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
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
        iconTheme: IconThemeData(color: darkPastelBrown),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: darkPastelBrown.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: darkPastelBrown,
              ),
              onPressed: () {
                // Handle notifications
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section with improved design
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightPastelBrown,
                    pastelBrown,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkPastelBrown.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkPastelBrown.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/user1.png'),
                      radius: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Volunteer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Ready to help others today?',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Quick Actions Title with decorative element
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: darkPastelBrown,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C4E3D),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.volunteer_activism,
                  size: 16,
                  color: darkPastelBrown.withOpacity(0.3),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Action Cards Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  ActionCard(
                    title: 'Profile',
                    color: darkPastelBrown,
                    lightColor: lightPastelBrown,
                    icon: Icons.verified_user,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => volunteerviewprofile(title: '')),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'Change Password',
                    color: darkPastelBrown,
                    lightColor: lightPastelBrown,
                    icon: Icons.lock_reset,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => vchangepass(title: '')),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'View Requests',
                    color: darkPastelBrown,
                    lightColor: lightPastelBrown,
                    icon: Icons.list_alt,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => viewvolunteerrequest(title: '')),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'Approved Requests',
                    color: darkPastelBrown,
                    lightColor: lightPastelBrown,
                    icon: Icons.check_circle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => viewapprovedrequest(title: '')),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'Logout',
                    color: darkPastelBrown,
                    lightColor: lightPastelBrown,
                    icon: Icons.logout,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => myloginpage(title: '')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightPastelBrown.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: darkPastelBrown,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textBrown,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: mediumPastelBrown,
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color lightColor;
  final IconData icon;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.color,
    required this.lightColor,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              lightColor.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            splashColor: color.withOpacity(0.1),
            highlightColor: color.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF5C4E3D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 30,
                    height: 2,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}