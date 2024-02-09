
import 'package:app_ciudadano/data/webService/dto/comparendo/infraccion_dto.dart';
import 'package:app_ciudadano/domain/models/comparendo/infraccion_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class InfraccionAdapter extends ModelAdapter<InfraccionModel, InfraccionDto> {
  @override
  InfraccionDto fromModel(InfraccionModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  InfraccionModel toModel(InfraccionDto external) => InfraccionModel(
    descripcion: external.descripcion, active: external.active,
    cantidadSDLV: external.cantidadSDLV, infraccionId: external.infraccionId,
    infractionCode: external.infractionCode );
}