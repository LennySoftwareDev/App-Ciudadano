class AccidenteModel {
  int ipatId;
  String numero;
  String fechaHoraAccidente;
  String fechaHoraLevantamiento;
  String complementoDireccion;
  String anio;
  AccidenteModel({
    required this.ipatId,
    required this.numero,
    required this.fechaHoraAccidente,
    required this.fechaHoraLevantamiento,
    required this.complementoDireccion,
    required this.anio,
  });
}
