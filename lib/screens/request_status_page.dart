import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rating_popup.dart';

class RequestStatusPage extends StatelessWidget {
  final String requestId;

  const RequestStatusPage({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request Status",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("requests")
            .doc(requestId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          String device = data["device"] ?? "";
          String problem = data["problem"] ?? "";
          String status = data["status"] ?? "pending";
          DateTime createdAt = data["createdAt"].toDate();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Progress steps (dynamic)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StepCircle(label: "Processing", active: status == "processing" || status == "accepted" || status == "ontheway" || status == "completed"),
                      const _ConnectorLine(),
                      _StepCircle(label: "Accepted", active: status == "accepted" || status == "ontheway" || status == "completed"),
                      const _ConnectorLine(),
                      _StepCircle(label: "On the way", active: status == "ontheway" || status == "completed"),
                      const _ConnectorLine(),
                      _StepCircle(label: "Completed", active: status == "completed"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Request Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Device: $device"),
                      Text("Problem: $problem"),
                      Text("Date: ${createdAt.toString()}"),
                      Text(
                        "Status: $status",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Worker Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/worker.jpg'),
                  ),
                  title: const Text(
                    "Ahmed Al-Sayyan",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text("⭐ 4.8"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Call"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Message"),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const RatingPopup(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Cancel Request",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final String label;
  final bool active;

  const _StepCircle({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: active ? Colors.green : Colors.grey.shade400,
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ConnectorLine extends StatelessWidget {
  const _ConnectorLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 30,
      color: Colors.grey.shade400,
    );
  }
}
