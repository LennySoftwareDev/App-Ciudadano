import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class AccidenteDto {
  final int ipatId;
  final String numero;
  final String fechaHoraAccidente;
  final String fechaHoraLevantamiento;
  final String complementoDireccion;
  final String anio;

  const AccidenteDto(this.ipatId, this.numero, this.fechaHoraAccidente, this.fechaHoraLevantamiento, this.complementoDireccion, this.anio);
  

  Map<String, dynamic> toMap() {
    return {
      'ipatId': ipatId,
      'numero': numero,
      'fechaHoraAccidente': fechaHoraAccidente,
      'fechaHoraLevantamiento': fechaHoraLevantamiento,
      'complementoDireccion': complementoDireccion,
      'anio': anio,
    };
  }

  factory AccidenteDto.fromMap(Map<String, dynamic> map) {
    return AccidenteDto(
      map['ipatId']?.toInt() ?? 0,
      map['numero'] ?? '',
      map['fechaHoraAccidente'] ?? '',
      map['fechaHoraLevantamiento'] ?? '',
      map['complementoDireccion'] ?? '',
      map['anio'] ?? '',
    );
  }

  static List<AccidenteDto> listMapToListDto(List<dynamic> list) {
    List<AccidenteDto> listAccidenteDto = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        try {
          listAccidenteDto.add(AccidenteDto.fromMap(element));
        } catch (e) {
          print(e);
        }
        
      }
    }
    return listAccidenteDto;
  }

  String toJson() => json.encode(toMap());

  factory AccidenteDto.fromJson(String source) => AccidenteDto.fromMap(json.decode(source));
}
