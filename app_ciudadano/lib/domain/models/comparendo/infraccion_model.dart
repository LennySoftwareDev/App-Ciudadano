class InfraccionModel {
  InfraccionModel({
    required this.infraccionId,
    required this.infractionCode,
    required this.cantidadSDLV,
    required this.descripcion,
    required this.active,
  });
  final int infraccionId;
  final int? infractionCode;
  final int cantidadSDLV;
  final String descripcion;
  final bool active;
}