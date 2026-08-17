// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:socialcare/user/vievolunteers.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Send Feedback',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const SendFeedback(title: 'Send Feedback'),
//     );
//   }
// }
//
// class SendFeedback extends StatefulWidget {
//   const SendFeedback({super.key, required this.title});
//   final String title;
//
//   @override
//   State<SendFeedback> createState() => _SendFeedbackState();
// }
//
// class _SendFeedbackState extends State<SendFeedback> {
//   final TextEditingController reviewController = TextEditingController();
//   double _userRating = 3.0;
//   bool _isLoading = false;
//
//   Future<void> _sendData() async {
//     String review = reviewController.text.trim();
//
//     if (review.isEmpty) {
//       Fluttertoast.showToast(msg: "Please enter review");
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? "";
//       String lid = sh.getString('lid') ?? "";
//       String vid = sh.getString('vid') ?? "";
//
//       final uri = Uri.parse('$url/userfeedback/');
//
//       final response = await http.post(
//         uri,
//         body: {
//           'rating': _userRating.toString(),
//           'review': review,
//           'vid': vid,
//           'lid': lid,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         if (jsonData['status'] == 'ok') {
//           Fluttertoast.showToast(msg: "Feedback Sent Successfully");
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const viewvolunteer(title: ''),
//             ),
//           );
//         } else {
//           Fluttertoast.showToast(msg: "Failed to send feedback");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Server Error");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     reviewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             /// ⭐ Rating Bar
//             RatingBar.builder(
//               initialRating: _userRating,
//               minRating: 1,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding:
//               const EdgeInsets.symmetric(horizontal: 4.0),
//               itemBuilder: (context, _) =>
//               const Icon(Icons.star, color: Colors.amber),
//               onRatingUpdate: (rating) {
//                 setState(() {
//                   _userRating = rating;
//                 });
//               },
//             ),
//
//             const SizedBox(height: 30),
//
//             /// 📝 Review Field
//             TextFormField(
//               controller: reviewController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Enter your review',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             /// 💾 Save Button
//             _isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: _sendData,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 40, vertical: 15),
//               ),
//               child: const Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialcare/user/vievolunteers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Feedback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD9B382), // Pastel brown
          primary: const Color(0xFFD9B382), // Pastel brown
          secondary: const Color(0xFFE8D5B5), // Light pastel tan
          surface: const Color(0xFFFFF8F0), // Cream
          background: const Color(0xFFFDF3E4), // Soft cream
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF3E4), // Soft cream
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFC4A484), // Pastel brown
          foregroundColor: Color(0xFFFDF8F2), // Cream white
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFFDF8F2),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            fontFamily: 'Georgia',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC4A484), // Pastel brown
            foregroundColor: const Color(0xFFFDF8F2), // Cream white
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFF8F0), // Cream
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFFE8D5B5), // Light pastel tan
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFFE8D5B5), // Light pastel tan
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFFD9B382), // Pastel brown
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF8B6B4D), // Muted brown
            fontFamily: 'Georgia',
          ),
        ),
        fontFamily: 'Georgia',
        useMaterial3: true,
      ),
      home: const SendFeedback(title: 'Send Feedback'),
    );
  }
}

class SendFeedback extends StatefulWidget {
  const SendFeedback({super.key, required this.title});
  final String title;

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  final TextEditingController reviewController = TextEditingController();
  double _userRating = 3.0;
  bool _isLoading = false;

  Future<void> _sendData() async {
    String review = reviewController.text.trim();

    if (review.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter review",
        backgroundColor: const Color(0xFFC4A484), // Pastel brown
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url') ?? "";
      String lid = sh.getString('lid') ?? "";
      String vid = sh.getString('vid') ?? "";

      final uri = Uri.parse('$url/userfeedback/');

      final response = await http.post(
        uri,
        body: {
          'rating': _userRating.toString(),
          'review': review,
          'vid': vid,
          'lid': lid,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          Fluttertoast.showToast(
            msg: "Feedback Sent Successfully",
            backgroundColor: const Color(0xFFC4A484), // Pastel brown
            textColor: Colors.white,
            fontSize: 16,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const viewvolunteer(title: ''),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Failed to send feedback",
            backgroundColor: const Color(0xFFC4A484), // Pastel brown
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server Error",
          backgroundColor: const Color(0xFFC4A484), // Pastel brown
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: const Color(0xFFC4A484), // Pastel brown
        textColor: Colors.white,
        fontSize: 16,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        width: double.infinity,
        height: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Decorative header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8D5B5).withOpacity(0.3), // Light pastel tan
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Share Your Experience",
                  style: TextStyle(
                    color: Color(0xFF8B6B4D), // Muted brown
                    fontSize: 18,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// ⭐ Rating Bar with pastel styling
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8F0), // Cream
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD9B382).withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Your Rating",
                      style: TextStyle(
                        color: Color(0xFF8B6B4D), // Muted brown
                        fontSize: 16,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: _userRating,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: const Color(0xFFD9B382), // Pastel brown stars
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _userRating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 📝 Review Field with pastel styling
              TextFormField(
                controller: reviewController,
                maxLines: 4,
                style: const TextStyle(
                  color: Color(0xFF5C3E2E), // Dark brown text
                  fontFamily: 'Georgia',
                ),
                decoration: InputDecoration(
                  labelText: 'Enter your review',
                  labelStyle: const TextStyle(
                    color: Color(0xFF8B6B4D), // Muted brown
                    fontFamily: 'Georgia',
                  ),
                  hintText: 'Share your experience...',
                  hintStyle: TextStyle(
                    color: const Color(0xFFC4A484).withOpacity(0.5), // Pastel brown
                    fontFamily: 'Georgia',
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: const Icon(
                    Icons.edit_note,
                    color: Color(0xFFD9B382), // Pastel brown
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 💾 Save Button (pastel styled)
              _isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFFD9B382), // Pastel brown
                ),
              )
                  : ElevatedButton(
                onPressed: _sendData,
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Georgia',
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Decorative footer
              Text(
                "Your feedback helps us improve",
                style: TextStyle(
                  color: const Color(0xFFC4A484).withOpacity(0.7),
                  fontSize: 12,
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
