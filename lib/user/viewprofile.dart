// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socialcare/user/editprofile.dart';
// import 'package:socialcare/user/upgradeprofile.dart';
//
// import 'home.dart';
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
//       home: const ViewProfilePage(title: 'View Profile'),
//     );
//   }
// }
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//
//   _ViewProfilePageState()
//   {
//     _send_data();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
//         return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//
//
//               Column(
//                 children: [
//                   // Image(image: NetworkImage(photo_),height: 200,width: 200,),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                   child: Text(name_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(email_),
//                   ),
//                   // Padding(
//                   //   padding: EdgeInsets.all(5),
//                   //   child: Text(gender_),
//                   // ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(phonenum_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(place_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(post_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(pin_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(idnum_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(role_),
//                   ),
//
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => user_edit_profile(title: "Edit Profile"),));
//                 },
//                 child: Text("Edit Profile"),
//               ),
//
//               ElevatedButton(
//                 onPressed: () async {
//
//
//                   SharedPreferences sh=await SharedPreferences.getInstance();
//                   sh.setString('userid',id_.toString() );
//                   sh.setString('useremail', email_.toString());
//
//
//
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => upgradeprofile(title: "upgrade profile to volunteer"),));
//                 },
//                 child: Text("upgrade profile to volunteer"),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   String name_="";
//   String id_="";
//   String email_="";
//   String phonenum_="";
//   String place_="";
//   String post_="";
//   String pin_="";
//   String district_="";
//   // String status="";
//   String idnum_="";
//   String role_="";
//
//   void _send_data() async{
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_viewprofile/');
//     try {
//       final response = await http.post(urls, body: {
//       'lid':lid
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String name=jsonDecode(response.body)['name'].toString();
//           String id=jsonDecode(response.body)['id'].toString();
//           String phonenumber=jsonDecode(response.body)['phonenum'].toString();
//           String email=jsonDecode(response.body)['email'].toString();
//           String district=jsonDecode(response.body)['district'].toString();
//           String place=jsonDecode(response.body)['place'].toString();
//           String post=jsonDecode(response.body)['post'].toString();
//           String pin=jsonDecode(response.body)['pin'].toString();
//           String idnum=jsonDecode(response.body)['idnum'].toString();
//           String role=jsonDecode(response.body)['role'].toString();
//
//           setState(() {
//             id_=id;
//             name_= name;
//             email_= email;
//             phonenum_= phonenumber;
//             place_= place;
//             post_= post;
//             pin_= pin;
//             district_= district;
//             idnum_= idnum;
//             role_= role;
//
//
//
//
//           });
//
//
//
//
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }







import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialcare/user/editprofile.dart';
import 'package:socialcare/user/upgradeprofile.dart';
import 'home.dart';

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
      home: const ViewProfilePage(title: 'My Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  // Pastel brown color palette
  final Color pastelBrown = const Color(0xFFD7C0AE);
  final Color lightPastelBrown = const Color(0xFFEAD7C3);
  final Color mediumPastelBrown = const Color(0xFFB7A99A);
  final Color darkPastelBrown = const Color(0xFF967E76);
  final Color warmBackground = const Color(0xFFF9F5F0);
  final Color textBrown = const Color(0xFF5C4E3D);

  _ViewProfilePageState() {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => userhome()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userhome()),
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
          child: Column(
            children: <Widget>[
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
                      width: 120,
                      height: 120,
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
                          name_.isNotEmpty ? name_[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      name_,
                      style: TextStyle(
                        fontSize: 28,
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
                        role_,
                        style: TextStyle(
                          color: darkPastelBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Profile Information Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildInfoCard(
                      'Personal Information',
                      Icons.person_outline,
                      [
                        _buildInfoRow(Icons.email_outlined, 'Email', email_),
                        _buildInfoRow(Icons.phone_outlined, 'Phone', phonenum_),
                        _buildInfoRow(Icons.badge_outlined, 'ID Number', idnum_),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildInfoCard(
                      'Address Details',
                      Icons.location_on_outlined,
                      [
                        _buildInfoRow(Icons.location_city, 'Place', place_),
                        _buildInfoRow(Icons.local_post_office, 'Post', post_),
                        _buildInfoRow(Icons.pin_drop, 'PIN', pin_),
                        _buildInfoRow(Icons.map, 'District', district_),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'Edit Profile',
                            Icons.edit,
                            darkPastelBrown,
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => user_edit_profile(title: "Edit Profile"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'Upgrade to Volunteer',
                            Icons.volunteer_activism,
                            mediumPastelBrown,
                                () async {
                              SharedPreferences sh = await SharedPreferences.getInstance();
                              sh.setString('userid', id_.toString());
                              sh.setString('useremail', email_.toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => upgradeprofile(title: "Upgrade Profile to Volunteer"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lightPastelBrown.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: darkPastelBrown,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBrown,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: lightPastelBrown.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 14,
              color: darkPastelBrown,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: mediumPastelBrown,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
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
              icon,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String name_ = "";
  String id_ = "";
  String email_ = "";
  String phonenum_ = "";
  String place_ = "";
  String post_ = "";
  String pin_ = "";
  String district_ = "";
  String idnum_ = "";
  String role_ = "";

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
          String id = jsonDecode(response.body)['id'].toString();
          String phonenumber = jsonDecode(response.body)['phonenum'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String district = jsonDecode(response.body)['district'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String post = jsonDecode(response.body)['post'].toString();
          String pin = jsonDecode(response.body)['pin'].toString();
          String idnum = jsonDecode(response.body)['idnum'].toString();
          String role = jsonDecode(response.body)['role'].toString();

          setState(() {
            id_ = id;
            name_ = name;
            email_ = email;
            phonenum_ = phonenumber;
            place_ = place;
            post_ = post;
            pin_ = pin;
            district_ = district;
            idnum_ = idnum;
            role_ = role;
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
}