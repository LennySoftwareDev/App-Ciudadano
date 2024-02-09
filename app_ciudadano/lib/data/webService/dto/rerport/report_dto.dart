


import 'dart:convert';

import 'package:app_ciudadano/data/webService/dto/rerport/location_dto.dart';
import 'package:flutter/foundation.dart';

@immutable
class ReportDto {
  final int? idDenuncia;
  final String usuarioId;
  final String descripcion;
  final String mensajeRespuesta;
  final String creadoEn;
  final bool publicado;
  final int tipoDenunciaId;
  final LocationDto ubicacion;
  final String? direccion;
  final List<String> imagenes;
  const ReportDto({
    this.idDenuncia,
    required this.usuarioId,
    required this.descripcion,
    required this.mensajeRespuesta,
    required this.creadoEn,
    required this.publicado,
    required this.tipoDenunciaId,
    required this.ubicacion,
    this.direccion,
    required this.imagenes,
  });

  Map<String, dynamic> toMap() {
    return {
      'idDenuncia': idDenuncia,
      'usuarioId': usuarioId,
      'descripcion': descripcion,
      'mensajeRespuesta': mensajeRespuesta,
      'creadoEn': creadoEn,
      'publicado': publicado,
      'tipoDenunciaId': tipoDenunciaId,
      'ubicacion': ubicacion.toMap(),
      'direccion': direccion,
      'imagenes': imagenes,
    };
  }

  factory ReportDto.fromMap(Map<String, dynamic> map) {
    return ReportDto(
      idDenuncia: map['denunciaId']?.toInt(),
      usuarioId: map['usuarioId'],
      descripcion: map['descripcion'] ?? '',
      mensajeRespuesta: map['mensajeRespuesta'] ?? '',
      creadoEn: map['creadoEn'] ?? '',
      publicado: map['publicado'] ?? false,
      tipoDenunciaId: map['tipoDenunciaId']?.toInt() ?? 0,
      ubicacion: LocationDto.fromMap(map['ubicacion']),
      direccion: map['direccion'],
      imagenes: List<String>.from(map['imagenes']),
    );
  }

  static List<ReportDto> listMapToListDto(List<dynamic> list) {
    List<ReportDto> listReportDto = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        try {
          listReportDto.add(ReportDto.fromMap(element));
        } catch (e) {
          print(e);
        }
        
      }
    }
    return listReportDto;
  }

  String toJson() => json.encode(toMap());

  factory ReportDto.fromJson(String source) => ReportDto.fromMap(json.decode(source));
}
