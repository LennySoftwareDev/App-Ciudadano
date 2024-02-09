import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class PersonaDto {
  const PersonaDto(
      this.personaId,
      this.identificacion,
      this.primerNombre,
      this.segundoNombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.numerodocumento,
      this.direccion,
      this.telefonoFijo,
      this.telefonoCelular,
      this.direccionResidencia,
      this.correoElectronico,
      this.tipoDocumento);

  final int personaId;
  final String identificacion;
  final String primerNombre;
  final String segundoNombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String numerodocumento;
  final String direccion;
  final String telefonoFijo;
  final String telefonoCelular;
  final String direccionResidencia;
  final String correoElectronico;
  final int tipoDocumento;

  Map<String, dynamic> toMap() {
    return {
      'personaId': personaId,
      'identificacion': identificacion,
      'primerNombre': primerNombre,
      'segundoNombre': segundoNombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'numerodocumento': numerodocumento,
      'direccion': direccion,
      'telefonoFijo': telefonoFijo,
      'telefonoCelular': telefonoCelular,
      'direccionResidencia': direccionResidencia,
      'correoElectronico': correoElectronico,
      'tipoDocumentoId' : tipoDocumento
    };
  }

  factory PersonaDto.fromMap(Map<String, dynamic> map) {
    return PersonaDto(
      map['personaId']?.toInt() ?? 0,
      map['identificacion'] ?? '',
      map['primerNombre'] ?? '',
      map['segundoNombre'] ?? '',
      map['apellidoPaterno'] ?? '',
      map['apellidoMaterno'] ?? '',
      map['numerodocumento'] ?? '',
      map['direccion'] ?? '',
      map['telefonoFijo'] ?? '',
      map['telefonoCelular'] ?? '',
      map['direccionResidencia'] ?? '',
      map['correoElectronico'] ?? '',
      map['tipoDocumentoId'] ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonaDto.fromJson(String source) =>
      PersonaDto.fromMap(json.decode(source));
}
