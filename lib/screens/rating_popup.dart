import 'package:flutter/material.dart';

class RatingPopup extends StatefulWidget {
  const RatingPopup({super.key});

  @override
  State<RatingPopup> createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  double rating = 3;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Cancel Request",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Please rate your experience before canceling:"),
          const SizedBox(height: 12),

          // Rating slider
          Slider(
            value: rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: rating.toString(),
            onChanged: (value) {
              setState(() {
                rating = value;
              });
            },
          ),

          const SizedBox(height: 10),
          Text("Rating: ${rating.toStringAsFixed(1)} ⭐"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}