// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AreaModel {
  final String nameArea;
  final Timestamp timestamp;
  final List<GeoPoint> geoPoint;
final String qrCode;


  AreaModel({
    required this.nameArea,
    required this.timestamp,
    required this.geoPoint,
    required this.qrCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameArea': nameArea,
      'timestamp': timestamp,
      'geoPoint': geoPoint.map((x) => x).toList(),
      'qrCode': qrCode,
    };
  }

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      nameArea: map['nameArea'] as String,
      timestamp: (map['timestamp']  ?? Timestamp(0, 0)),
      geoPoint: List<GeoPoint>.from((map['geoPoint'] ?? [])),
      qrCode: map['qrCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaModel.fromJson(String source) =>
      AreaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
