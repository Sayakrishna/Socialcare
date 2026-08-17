import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

void main() {
  runApp(const SymptomBasedPredictionApp());
}

class SymptomBasedPredictionApp extends StatelessWidget {
  const SymptomBasedPredictionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Symptom Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SymptomBasedPredictionPage(),
    );
  }
}

class SymptomBasedPredictionPage extends StatefulWidget {
  const SymptomBasedPredictionPage({Key? key}) : super(key: key);

  @override
  State<SymptomBasedPredictionPage> createState() => _SymptomBasedPredictionPageState();
}

class _SymptomBasedPredictionPageState extends State<SymptomBasedPredictionPage> {
  List<String> symptoms = [];
  List<String> selectedSymptoms = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchSymptoms();
  }

  Future<void> fetchSymptoms() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final baseUrl = prefs.getString('url') ?? '';
      final url = '$baseUrl/user_view_symptoms/';

      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          final List data = jsonData['data'];
          setState(() {
            symptoms = data.map((item) => item['name'].toString()).toList();
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load symptoms');
        }
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load symptoms. Please try again.';
        isLoading = false;
      });
    }
  }

  Future<void> predictDisease() async {
    if (selectedSymptoms.isEmpty) {
      Fluttertoast.showToast(msg: "Please select at least one symptom");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('url') ?? '';
    final url = '$baseUrl/predictdiseasebysymptoms/';

    // Change this line - use ',' instead of '#'
    final symptomsString = selectedSymptoms.join(',');  // FIXED: was '#'

    try {
      final response = await http.post(Uri.parse(url), body: {'s': symptomsString});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          final predictedDisease = jsonData['predicted_disease'];  // FIXED: was 'data'
          final matchPercentage = jsonData['match_percentage'];

          if (!mounted) return;
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Row(
                children: [
                  Icon(Icons.health_and_safety, color: Colors.teal),
                  SizedBox(width: 10),
                  Text("Prediction Result"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Based on your symptoms, the AI predicts:",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "🩺 $predictedDisease",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Match: $matchPercentage%",
                    style: const TextStyle(fontSize: 14, color: Colors.teal),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        } else {
          Fluttertoast.showToast(msg: jsonData['message'] ?? "No prediction found");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Prediction failed: $e");
    }
  }

  // Future<void> predictDisease() async {
  //   if (selectedSymptoms.isEmpty) {
  //     Fluttertoast.showToast(msg: "Please select at least one symptom");
  //     return;
  //   }
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final baseUrl = prefs.getString('url') ?? '';
  //   final url = '$baseUrl/predictdiseasebysymptoms/';
  //
  //   final symptomsString = selectedSymptoms.map((s) => s).join('#');
  //
  //   try {
  //     final response = await http.post(Uri.parse(url), body: {'s': symptomsString});
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       if (jsonData['status'] == 'ok') {
  //         final predictedDisease = jsonData['data'];
  //
  //         if (!mounted) return;
  //         showDialog(
  //           context: context,
  //           builder: (ctx) => AlertDialog(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //             title: const Row(
  //               children: [
  //                 Icon(Icons.health_and_safety, color: Colors.teal),
  //                 SizedBox(width: 10),
  //                 Text("Prediction Result"),
  //               ],
  //             ),
  //             content: Text(
  //               "Based on your symptoms, the AI predicts:\n\n🩺 $predictedDisease",
  //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(ctx),
  //                 child: const Text("Close"),
  //               ),
  //             ],
  //           ),
  //         );
  //       } else {
  //         Fluttertoast.showToast(msg: "No prediction found");
  //       }
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Prediction failed. Try again.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: fetchSymptoms,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      )
          : Column(
        children: [
          // Selected Symptoms Chips
          if (selectedSymptoms.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.teal.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Selected Symptoms:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: selectedSymptoms
                        .map((symptom) => Chip(
                      label: Text(symptom),
                      backgroundColor: Colors.teal.shade100,
                      deleteIconColor: Colors.teal.shade700,
                      onDeleted: () {
                        setState(() {
                          selectedSymptoms.remove(symptom);
                        });
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Select all symptoms you are experiencing:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                final symptom = symptoms[index];
                final isSelected = selectedSymptoms.contains(symptom);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: CheckboxListTile(
                    title: Text(
                      symptom,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.teal.shade800 : null,
                      ),
                    ),
                    value: isSelected,
                    activeColor: Colors.teal,
                    checkboxShape: const CircleBorder(),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedSymptoms.add(symptom);
                        } else {
                          selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                    secondary: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? Colors.teal : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: selectedSymptoms.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: predictDisease,
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.psychology, color: Colors.white),
        label: const Text("Predict Disease", style: TextStyle(color: Colors.white)),
      )
          : null,
    );
  }
}