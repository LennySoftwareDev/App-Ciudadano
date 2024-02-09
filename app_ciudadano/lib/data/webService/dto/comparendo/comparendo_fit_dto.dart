import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class ComparendoFitDto {
  final String numero;
  final String fechaHoraInfraccion;
  final String codigoNuevo;
  final String descripcion;
  final String tipoComparendo;
  final int valor;
  final String pdfUrl;

  const ComparendoFitDto(
      this.numero,
      this.fechaHoraInfraccion,
      this.codigoNuevo,
      this.descripcion,
      this.tipoComparendo,
      this.valor,
      this.pdfUrl);

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'fechaHoraInfraccion': fechaHoraInfraccion,
      'codigoNuevo': codigoNuevo,
      'descripcion': descripcion,
      'tipoComparendo': tipoComparendo,
      'valor': valor,
      'pdfUrl': pdfUrl
    };
  }

  factory ComparendoFitDto.fromMap(Map<String, dynamic> map) {
    return ComparendoFitDto(
      map['comparendoNumero'] ?? '',
      map['fechaHoraInfraccion'] ?? '',
      map["infraccion"]['codigoNuevo'] ?? '',
      map["infraccion"]['descripcion'] ?? '',
      map['tipoComparendo']["nombre"] ?? '',
      map['valor']?.toInt() ?? 0,
      map['pdfUrl'] ?? '',
    );
  }

  static List<ComparendoFitDto> listMapToListDto(List<dynamic> list) {
    List<ComparendoFitDto> listComparendoFitDto = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        try {
          listComparendoFitDto.add(ComparendoFitDto.fromMap(element));
        } catch (e) {
          print(e);
        }
      }
    }
    return listComparendoFitDto;
  }

  String toJson() => json.encode(toMap());

  factory ComparendoFitDto.fromJson(String source) =>
      ComparendoFitDto.fromMap(json.decode(source));
}
