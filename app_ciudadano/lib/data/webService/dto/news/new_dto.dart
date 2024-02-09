import 'dart:convert';

import 'package:app_ciudadano/data/webService/dto/news/type_new_dto.dart';
import 'package:flutter/foundation.dart';

@immutable
class NewDto {
  final int idNovedad;
  final int tipoNovedadId;
  final TypeNewDto? tipoNovedad;
  final String nombre;
  final String creadoEn;
  final String publicadoEn;
  final String descripcion;
  final String usuarioId;
  final bool publicado;
  final List<String> imagenes;

  const NewDto(this.idNovedad, this.tipoNovedadId, this.tipoNovedad, this.nombre, this.creadoEn, this.publicadoEn, this.descripcion, this.usuarioId, this.publicado, this.imagenes);

  Map<String, dynamic> toMap() {
    return {
      'idNovedad': idNovedad,
      'tipoNovedadId': tipoNovedadId,
      'tipoNovedad': tipoNovedad != null ? tipoNovedad!.toMap() : null,
      'nombre': nombre,
      'creadoEn': creadoEn,
      'publicadoEn': publicadoEn,
      'descripcion': descripcion,
      'usuarioId': usuarioId,
      'publicado': publicado,
      'listImg': imagenes,
    };
  }

  factory NewDto.fromMap(Map<String, dynamic> map) {
   
    return NewDto(
      map['idNovedad']?.toInt() ?? 0,
      map['tipoNovedadId']?.toInt() ?? 0,
      map['tipoNovedad'] != null ? TypeNewDto.fromMap(map['tipoNovedad']) : null,
      map['nombre'] ?? '',
      map['creadoEn'] ?? '',
      map['publicadoEn'] ?? '',
      map['descripcion'] ?? '',
      '${map['usuarioId']}',
      map['publicado'] ?? false,
      map['imagenes'] != null ? List<String>.from(map['imagenes']) : [],
    );
  }

  static List<NewDto> listMapToListDto(List<dynamic> list) {
    List<NewDto> listNewDto = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        try {
          listNewDto.add(NewDto.fromMap(element));
        } catch (e) {
          print(e);
        }
        
      }
    }
    return listNewDto;
  }

  String toJson() => json.encode(toMap());

  factory NewDto.fromJson(String source) => NewDto.fromMap(json.decode(source));
}
