
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class InfraccionDto {
  const InfraccionDto(
    this.infraccionId,
    this.infractionCode,
    this.cantidadSDLV,
    this.descripcion,
    this.active,
    this.isRelatedToSpeed,
    this.nuevoCodigoCorregido,
  );
  final int infraccionId;
  final int infractionCode;
  final int cantidadSDLV;
  final String descripcion;
  final bool active;
  final bool isRelatedToSpeed;
  final String nuevoCodigoCorregido;

  Map<String, dynamic> toMap() {
    return {
      'infraccionId': infraccionId,
      'infractionCode': infractionCode,
      'cantidadSDLV': cantidadSDLV,
      'descripcion': descripcion,
      'active': active,
      'isRelatedToSpeed': isRelatedToSpeed,
      'nuevoCodigoCorregido': nuevoCodigoCorregido,
    };
  }

  factory InfraccionDto.fromMap(Map<String, dynamic> map) {
    return InfraccionDto(
      map['infraccionId']?.toInt() ?? 0,
      map['infractionCode']?.toInt() ?? 0,
      map['cantidadSDLV']?.toInt() ?? 0,
      map['descripcion'] ?? '',
      map['active'] ?? false,
      map['isRelatedToSpeed'] ?? false,
      map['nuevoCodigoCorregido'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InfraccionDto.fromJson(String source) => InfraccionDto.fromMap(json.decode(source));
}
