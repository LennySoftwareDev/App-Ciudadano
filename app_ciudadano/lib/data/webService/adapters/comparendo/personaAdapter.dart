import 'package:app_ciudadano/data/webService/dto/comparendo/persona_dto.dart';
import 'package:app_ciudadano/domain/models/comparendo/persona_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class PersonaAdapter extends ModelAdapter<PersonaModel, PersonaDto> {
  @override
  PersonaDto fromModel(PersonaModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  PersonaModel toModel(PersonaDto external) => PersonaModel(
    apellidoPaterno: external.apellidoPaterno,
    direccion: external.direccion,
    identificacion: external.identificacion,
    numerodocumento: external.numerodocumento,
    personaId: external.personaId,
    primerNombre: external.primerNombre,
    telefonoCelular: external.telefonoCelular,
    apellidoMaterno: external.apellidoMaterno,
    correoElectronico: external.correoElectronico,
    direccionResidencia: external.direccionResidencia,
    segundoNombre: external.segundoNombre,
    telefonoFijo: external.telefonoFijo,
    tipoDocumento: external.tipoDocumento
     );
}