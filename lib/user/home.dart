// import 'package:flutter/material.dart';
// import 'package:socialcare/user/changepassword.dart';
// import 'package:socialcare/user/sendrequest.dart';
// import 'package:socialcare/user/vievolunteers.dart';
// import 'package:socialcare/user/viewprofile.dart';
// import 'package:socialcare/user/viewrequest.dart';
//
// import '../login.dart';
// import '../main.dart';
//
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: userhome(),
//   ));
// }
//
// class userhome extends StatefulWidget {
//   const userhome({super.key});
//
//   @override
//   State<userhome> createState() => _userhomeState();
// }
//
// class _userhomeState extends State<userhome> {
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
//                       'Hi user,',
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
//                         MaterialPageRoute(builder: (context) => ViewProfilePage(title: '')),
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
//                   ActionCard(
//                     title: 'send request',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => sendrequest(title: '')),
//                       );
//                     },
//                   ),
//
//
//
//                   ActionCard(
//                     title: 'view request',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Viewrequest(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'view volunteer',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => viewvolunteer(title: '')),
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
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => myloginpage(title: '')),
//                       );
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




import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:socialcare/user/changepassword.dart';
import 'package:socialcare/user/sendrequest.dart';
import 'package:socialcare/user/vievolunteers.dart';
import 'package:socialcare/user/viewprofile.dart';
import 'package:socialcare/user/viewrequest.dart';
import 'package:http/http.dart' as http;
import '../login.dart';
import 'Symptombasedprediction.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: userhome(),
  ));
}

class userhome extends StatefulWidget {
  const userhome({super.key});

  @override
  State<userhome> createState() => _userhomeState();
}

class _userhomeState extends State<userhome> {


  _userhomeState(){
    _send_data();
    _count_data();
  }

  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);


  String name_ = "";
  String pcount_="";
  String acount_="";
  String rcount_="";



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
          String name = jsonDecode(response.body)['name'].toString();


          setState(() {
            name_ = name;
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


  void _count_data() async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/homecount/');
    try {
      final response = await http.post(urls, body: {
      'lid':lid

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String pcount=jsonDecode(response.body)['pcount'].toString();
          String rcount=jsonDecode(response.body)['rcount'].toString();
          String acount=jsonDecode(response.body)['acount'].toString();

          setState(() {
            pcount_=pcount;
            rcount_= rcount;
            acount_= acount;
          });

        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
        return true;
      },
      child: Scaffold(
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
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
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
                          Text(
                            name_,
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
                              'What would you like to do today?',
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

              // Stats Section (keeping your empty structure but adding visual appeal)
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(pcount_, 'send', Icons.favorite),
                    _buildStatItem(acount_, 'approved', Icons.check_circle),
                    _buildStatItem(rcount_, 'Pending', Icons.hourglass_empty),
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
                    Icons.favorite,
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
                          MaterialPageRoute(builder: (context) => ViewProfilePage(title: '')),
                        );
                      },
                    ),

                    ActionCard(
                      title: 'disease prediction',
                      color: darkPastelBrown,
                      lightColor: lightPastelBrown,
                      icon: Icons.verified_user,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SymptomBasedPredictionPage()),
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
                          MaterialPageRoute(builder: (context) => changepassword(title: '')),
                        );
                      },
                    ),
                    ActionCard(
                      title: 'Send Request',
                      color: darkPastelBrown,
                      lightColor: lightPastelBrown,
                      icon: Icons.send,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => sendrequest(title: '')),
                        );
                      },
                    ),
                    ActionCard(
                      title: 'View Request',
                      color: darkPastelBrown,
                      lightColor: lightPastelBrown,
                      icon: Icons.list_alt,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Viewrequest(title: '')),
                        );
                      },
                    ),
                    ActionCard(
                      title: 'View Volunteer',
                      color: darkPastelBrown,
                      lightColor: lightPastelBrown,
                      icon: Icons.volunteer_activism,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => viewvolunteer(title: '')),
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