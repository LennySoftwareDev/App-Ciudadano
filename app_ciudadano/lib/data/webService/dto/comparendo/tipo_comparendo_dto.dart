
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class TipoComparendoDto {
  const TipoComparendoDto(
    this.trafficTicketId,
    this.nombre,
    this.descripcion,
  );
  final int trafficTicketId;
  final String nombre;
  final String descripcion;

  Map<String, dynamic> toMap() {
    return {
      'trafficTicketId': trafficTicketId,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory TipoComparendoDto.fromMap(Map<String, dynamic> map) {
    return TipoComparendoDto(
      map['trafficTicketId']?.toInt() ?? 0,
      map['nombre'] ?? '',
      map['descripcion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoComparendoDto.fromJson(String source) => TipoComparendoDto.fromMap(json.decode(source));
}
