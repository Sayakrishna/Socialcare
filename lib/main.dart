// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socialcare/login.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController ipc = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: ipc,
//               decoration: InputDecoration(labelText: 'ipaddress',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
//             SizedBox(height: 30,),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text('submit'))
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _incrementCounter,
//       //   tooltip: 'Increment',
//       //   child: const Icon(Icons.add),
//       // ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void _send_data() async{
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString('url', 'http://${ipc.text}:8000/myapp');
//     sh.setString('img_url', 'http://${ipc.text}:8000');
//     Navigator.push(context, MaterialPageRoute(
//       builder: (context) =>myloginpage(title: '',),));
//
//   }
// }




import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialcare/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocialCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD7C0AE), // Pastel brown seed color
          primary: const Color(0xFFB7A99A),   // Muted pastel brown
          secondary: const Color(0xFFEAD7C3), // Light pastel cream
          tertiary: const Color(0xFF967E76),  // Deeper pastel brown
          background: const Color(0xFFF9F5F0), // Warm off-white
        ),
        useMaterial3: true,
        fontFamily: 'Georgia', // Optional: adds elegance
      ),
      home: const MyHomePage(title: 'Welcome to SocialCare'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController ipc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF9F5F0), // Warm off-white
              const Color(0xFFEAD7C3), // Light pastel cream
              const Color(0xFFD7C0AE), // Pastel brown
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo/Icon Section
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF967E76),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      size: 60,
                      color: Color(0xFF967E76),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Welcome Text
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF967E76),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SocialCare',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5C4E3D),
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.brown.withOpacity(0.2),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Connect • Care • Support',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF967E76),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Input Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Server Configuration',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5C4E3D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please enter the server IP address to continue',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF967E76),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // IP Address Field
                        TextFormField(
                          controller: ipc,
                          style: const TextStyle(
                            color: Color(0xFF5C4E3D),
                          ),
                          decoration: InputDecoration(
                            labelText: 'IP Address',
                            labelStyle: TextStyle(
                              color: const Color(0xFF967E76),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: '192.168.1.100',
                            hintStyle: TextStyle(
                              color: const Color(0xFFB7A99A),
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.computer,
                              color: const Color(0xFF967E76),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: const Color(0xFFD7C0AE),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: const Color(0xFF967E76),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFD7C0AE),
                                const Color(0xFFB7A99A),
                                const Color(0xFF967E76),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF967E76).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _send_data,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Connect to Server',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Decorative Elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7C0AE),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.favorite,
                        size: 20,
                        color: const Color(0xFF967E76).withOpacity(0.5),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40,
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7C0AE),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Footer Text
                  Text(
                    'Making connections that matter',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF967E76).withOpacity(0.7),
                      fontStyle: FontStyle.italic,
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

  void _send_data() async {
    if (ipc.text.isNotEmpty) {
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString('url', 'http://${ipc.text}:8000/myapp');
      sh.setString('img_url', 'http://${ipc.text}:8000');

      // Show a brief success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connecting to ${ipc.text}...'),
          backgroundColor: const Color(0xFF967E76),
          duration: const Duration(seconds: 1),
        ),
      );

      // Navigate after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => myloginpage(title: ''),
          ),
        );
      });
    } else {
      // Show error if IP is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an IP address'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}