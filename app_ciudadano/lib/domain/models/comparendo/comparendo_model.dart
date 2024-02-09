import 'package:app_ciudadano/domain/models/comparendo/estado_comparendo_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/infraccion_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/persona_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/tipo_comparendo_model.dart';

class ComparendoModel {
  int comparendoId;
  String numero;
  String direccion;
  String localidad;
  String fechaHoraInfraccion;
  String fechaHoraRegistro;
  int valor;
  String placa;
  String codigo;
  EstadoComparendoModel estado;
  PersonaModel infractor;
  TipoComparendoModel tipoComparendo;
  InfraccionModel infraccion;
  PersonaModel propietario;
  String observation;
  int? velocidad;
  bool tieneReporteAlcolemia;
  int? nivelDeAlcohol;  
  ComparendoModel({
    required this.comparendoId,
    required this.numero,
    required this.direccion,
    required this.localidad,
    required this.fechaHoraInfraccion,
    required this.fechaHoraRegistro,
    required this.valor,
    required this.placa,
    required this.codigo,
    required this.estado,
    required this.infractor,
    required this.tipoComparendo,
    required this.infraccion,
    required this.propietario,
    required this.observation,
    required this.velocidad,
    required this.tieneReporteAlcolemia,
    this.nivelDeAlcohol,
  });
}
