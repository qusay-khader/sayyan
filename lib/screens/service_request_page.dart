import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'request_status_page.dart';

class ServiceRequestPage extends StatefulWidget {
  const ServiceRequestPage({super.key});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final TextEditingController deviceController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  bool isLoading = false;

  Future<void> createRequest() async {
    if (deviceController.text.isEmpty || problemController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference newRequest =
      await FirebaseFirestore.instance.collection("requests").add({
        "userId": userId,
        "device": deviceController.text.trim(),
        "problem": problemController.text.trim(),
        "status": "pending",
        "createdAt": DateTime.now(),
      });

      setState(() => isLoading = false);

      // الانتقال إلى صفحة حالة الطلب
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RequestStatusPage(requestId: newRequest.id), // Send request ID
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating request: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Request",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Device Type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: deviceController,
                decoration: InputDecoration(
                  hintText: "Type Your Device",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text("Problem Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: problemController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Please Describe the Problem...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: isLoading ? null : createRequest,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Submit Request",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
