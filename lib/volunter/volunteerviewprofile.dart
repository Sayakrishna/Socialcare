// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socialcare/volunter/volunteereditprofile.dart';
// import 'package:socialcare/volunter/volunteerhome.dart';
//
//
// void main() {
//   runApp(const ViewProfile());
// }
//
// class ViewProfile extends StatelessWidget {
//   const ViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Profile',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const volunteerviewprofile(title: 'View Profile'),
//     );
//   }
// }
//
// class volunteerviewprofile extends StatefulWidget {
//   const volunteerviewprofile({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<volunteerviewprofile> createState() =>
//       _volunteerviewprofileState();
// }
//
// class _volunteerviewprofileState
//     extends State<volunteerviewprofile> {
//
//   String skills_ = "";
//   String availability_ = "";
//   String status_ = "";
//   String assignedarea_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _send_data();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => volunteerhome()),
//         );
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           backgroundColor:
//           Theme.of(context).colorScheme.primary,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment:
//             CrossAxisAlignment.start,
//             children: [
//
//               Text("Skills: $skills_",
//                   style: TextStyle(fontSize: 16)),
//
//               const SizedBox(height: 8),
//
//               Text("Availability: $availability_",
//                   style: TextStyle(fontSize: 16)),
//
//               const SizedBox(height: 8),
//
//               Text("Status: $status_",
//                   style: TextStyle(fontSize: 16)),
//
//               const SizedBox(height: 8),
//
//               Text("Assigned Area: $assignedarea_",
//                   style: TextStyle(fontSize: 16)),
//
//               const SizedBox(height: 20),
//
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           VolunteerEditProfile(),
//                     ),
//                   );
//                 },
//                 child: const Text("Edit Profile"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _send_data() async {
//     try {
//       SharedPreferences sh =
//       await SharedPreferences.getInstance();
//
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       final response = await http.post(
//         Uri.parse('$url/volunteer_viewprofile/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           skills_ = data['skills'].toString();
//           availability_ = data['categories'].toString();
//           assignedarea_ = data['assigned_area'].toString();
//           status_ = data['volunteer_status'].toString();
//         });
//       } else {
//         Fluttertoast.showToast(
//             msg: "Profile not found");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialcare/volunter/volunteereditprofile.dart';
import 'package:socialcare/volunter/volunteerhome.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD7C0AE),
          primary: const Color(0xFFB7A99A),
          secondary: const Color(0xFFEAD7C3),
          tertiary: const Color(0xFF967E76),
          background: const Color(0xFFF9F5F0),
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const volunteerviewprofile(title: 'Volunteer Profile'),
    );
  }
}

class volunteerviewprofile extends StatefulWidget {
  const volunteerviewprofile({super.key, required this.title});

  final String title;

  @override
  State<volunteerviewprofile> createState() => _volunteerviewprofileState();
}

class _volunteerviewprofileState extends State<volunteerviewprofile> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  String skills_ = "";
  String availability_ = "";
  String status_ = "";
  String assignedarea_ = "";

  @override
  void initState() {
    super.initState();
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => volunteerhome()),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: warmBackground,
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => volunteerhome()),
                );
              },
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF967E76),
              ),
            ),
          ),
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
          child: Column(
            children: [
              // Profile Header with Avatar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      lightPastelBrown,
                      pastelBrown.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            darkPastelBrown,
                            mediumPastelBrown,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: darkPastelBrown.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          skills_.isNotEmpty ? skills_[0].toUpperCase() : 'V',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Volunteer Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textBrown,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: darkPastelBrown.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status_,
                        style: TextStyle(
                          color: status_.toLowerCase() == 'active'
                              ? Colors.green.shade700
                              : darkPastelBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Profile Information Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkPastelBrown.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Card Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lightPastelBrown,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: lightPastelBrown.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.volunteer_activism,
                              color: darkPastelBrown,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'Profile Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textBrown,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile Details
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.handyman,
                            'Skills',
                            skills_,
                          ),
                          _buildInfoRow(
                            Icons.access_time,
                            'Availability',
                            availability_,
                            valueColor: availability_.toLowerCase() == 'available'
                                ? Colors.green.shade700
                                : null,
                          ),
                          _buildInfoRow(
                            Icons.location_on,
                            'Assigned Area',
                            assignedarea_,
                          ),
                          _buildInfoRow(
                            Icons.circle,
                            'Status',
                            status_,
                            valueColor: status_.toLowerCase() == 'active'
                                ? Colors.green.shade700
                                : status_.toLowerCase() == 'inactive'
                                ? Colors.grey.shade600
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Edit Profile Button
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolunteerEditProfile(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

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
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightPastelBrown.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: darkPastelBrown,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: mediumPastelBrown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? textBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _send_data() async {
    try {
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
          skills_ = data['skills'].toString();
          availability_ = data['categories'].toString();
          assignedarea_ = data['assigned_area'].toString();
          status_ = data['volunteer_status'].toString();
        });
      } else {
        Fluttertoast.showToast(msg: "Profile not found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}