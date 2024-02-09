
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class EstadoComparendoDto {
  const EstadoComparendoDto(
    this.estadoId,
    this.nombre,
    this.descripcion,
  );
  final int estadoId;
  final String nombre;
  final String descripcion;

  Map<String, dynamic> toMap() {
    return {
      'estadoId': estadoId,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory EstadoComparendoDto.fromMap(Map<String, dynamic> map) {
    return EstadoComparendoDto(
      map['estadoId']?.toInt() ?? 0,
      map['nombre'] ?? '',
      map['descripcion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoComparendoDto.fromJson(String source) => EstadoComparendoDto.fromMap(json.decode(source));
}
