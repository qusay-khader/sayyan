import 'package:flutter/material.dart';
import 'rating_popup.dart';

class RequestStatusPage extends StatelessWidget {
  const RequestStatusPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Progress steps
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _StepCircle(label: "Processing", active: true),
                  _ConnectorLine(),
                  _StepCircle(label: "Accepted", active: true),
                  _ConnectorLine(),
                  _StepCircle(label: "On the way", active: false),
                  _ConnectorLine(),
                  _StepCircle(label: "Completed", active: false),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service Type: Phone Repair"),
                  Text("Description: Cracked Screen, Battery Replacement"),
                  Text("Date/Time: Nov 26, 2023, 3:00 PM"),
                  Text(
                    "Estimated Cost: 250 SAR",
                    style: TextStyle(color: Colors.green),
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
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Cancel Request",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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