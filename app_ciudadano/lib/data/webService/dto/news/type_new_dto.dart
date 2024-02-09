
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class TypeNewDto {
  final int id;
  final String nombre;

  const TypeNewDto(this.id, this.nombre);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory TypeNewDto.fromMap(Map<String, dynamic> map) {
    return TypeNewDto(
      map['id']?.toInt() ?? 0,
      map['nombre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeNewDto.fromJson(String source) => TypeNewDto.fromMap(json.decode(source));
}
