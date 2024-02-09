
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class LocationDto {
  final double lat;
  final double long;
  const LocationDto({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory LocationDto.fromMap(Map<String, dynamic> map) {
    return LocationDto(
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationDto.fromJson(String source) => LocationDto.fromMap(json.decode(source));
}
