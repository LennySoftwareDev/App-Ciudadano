
import 'dart:convert';

import 'package:app_ciudadano/data/webService/dto/comparendo/infraccion_dto.dart';
import 'package:app_ciudadano/data/webService/dto/comparendo/persona_dto.dart';
import 'package:app_ciudadano/data/webService/dto/comparendo/tipo_comparendo_dto.dart';
import 'package:flutter/foundation.dart';

import 'estado_comparendo_dto.dart';

@immutable
class ComparendoDto {
  const ComparendoDto(
    this.comparendoId,
    this.numero,
    this.direccion,
    this.localidad,
    this.fechaHoraInfraccion,
    this.fechaHoraRegistro,
    this.valor,
    this.placa,
    this.codigo,
    this.estado,
    this.infractor,
    this.tipoComparendo,
    this.infraccion,
    this.propietario,
    this.observation,
    this.speed,
    this.reportsAlcolemia,
    this.alcoholLevel,
  );
  final int comparendoId;
  final String numero;
  final String direccion;
  final String localidad;
  final String fechaHoraInfraccion;
  final String fechaHoraRegistro;
  final int valor;
  final String placa;
  final String codigo;
  final EstadoComparendoDto estado;
  final PersonaDto infractor;
  final TipoComparendoDto tipoComparendo;
  final InfraccionDto infraccion;
  final PersonaDto propietario;
  final String observation;
  final int? speed;
  final bool reportsAlcolemia;
  final int? alcoholLevel;  

  Map<String, dynamic> toMap() {
    return {
      'comparendoId': comparendoId,
      'numero': numero,
      'direccion': direccion,
      'localidad': localidad,
      'fechaHoraInfraccion': fechaHoraInfraccion,
      'fechaHoraRegistro': fechaHoraRegistro,
      'valor': valor,
      'placa': placa,
      'codigo': codigo,
      'estado': estado.toMap(),
      'infractor': infractor.toMap(),
      'tipoComparendo': tipoComparendo.toMap(),
      'infraccion': infraccion.toMap(),
      'propietario': propietario.toMap(),
      'observation': observation,
      'speed': speed,
      'reportsAlcolemia': reportsAlcolemia,
      'alcoholLevel': alcoholLevel,
    };
  }

  factory ComparendoDto.fromMap(Map<String, dynamic> map) {
    return ComparendoDto(
      map['comparendoId']?.toInt() ?? 0,
      map['numero'] ?? '',
      map['direccion'] ?? '',
      map['localidad'] ?? '',
      map['fechaHoraInfraccion'] ?? '',
      map['fechaHoraRegistro'] ?? '',
      map['valor']?.toInt() ?? 0,
      map['placa'] ?? '',
      map['codigo'] ?? '',
      EstadoComparendoDto.fromMap(map['estado']),
      PersonaDto.fromMap(map['infractor']),
      TipoComparendoDto.fromMap(map['tipoComparendo']),
      InfraccionDto.fromMap(map['infraccion']),
      PersonaDto.fromMap(map['propietario']),
      map['observation'] ?? '',
      map['speed']?.toInt(),
      map['reportsAlcolemia'] ?? false,
      map['alcoholLevel']?.toInt(),
    );
  }

  static List<ComparendoDto> listMapToListDto(List<dynamic> list) {
    List<ComparendoDto> listComparendoDto = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        try {
          listComparendoDto.add(ComparendoDto.fromMap(element));
        } catch (e) {
          print(e);
        }
        
      }
    }
    return listComparendoDto;
  }

  String toJson() => json.encode(toMap());

  factory ComparendoDto.fromJson(String source) => ComparendoDto.fromMap(json.decode(source));
}
