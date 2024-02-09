class PersonaModel {
  PersonaModel({
    this.personaId,
    this.identificacion,
    required this.primerNombre,
    this.segundoNombre,
    required this.apellidoPaterno,
    this.apellidoMaterno,
    required this.numerodocumento,
    this.direccion,
    this.telefonoFijo,
    required this.telefonoCelular,
    this.direccionResidencia,
    this.correoElectronico,
    required this.tipoDocumento
  });
  final int? personaId;
  final String? identificacion;
  final String primerNombre;
  final String? segundoNombre;
  final String apellidoPaterno;
  final String? apellidoMaterno;
  final String numerodocumento;
  final String? direccion;
  final String? telefonoFijo;
  final String? telefonoCelular;
  final String? direccionResidencia;
  final String? correoElectronico;
  final int tipoDocumento;
}