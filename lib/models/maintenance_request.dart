import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenanceRequest {
  final String id;
  final String userId;
  final String deviceType;
  final String problemDetails;
  final List<String> images;
  final String status; // pending, accepted, rejected
  final DateTime createdAt;
  final DateTime? updatedAt;

  MaintenanceRequest({
    required this.id,
    required this.userId,
    required this.deviceType,
    required this.problemDetails,
    this.images = const [],
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  // من Firestore إلى Object
  factory MaintenanceRequest.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MaintenanceRequest(
      id: doc.id,
      userId: data['userId'] ?? '',
      deviceType: data['deviceType'] ?? '',
      problemDetails: data['problemDetails'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // من Object إلى Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'deviceType': deviceType,
      'problemDetails': problemDetails,
      'images': images,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  static getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return const Color(0xFF4CAF50);
      case 'rejected':
        return const Color(0xFFf44336);
      default:
        return const Color(0xFFFFA726);
    }
  }
}
