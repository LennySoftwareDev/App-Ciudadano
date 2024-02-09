
import 'package:app_ciudadano/data/webService/adapters/comparendo/infraccionAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/personaAdapter.dart';
import 'package:app_ciudadano/data/webService/dto/comparendo/comparendo_dto.dart';
import 'package:app_ciudadano/domain/models/comparendo/comparendo_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/estado_comparendo_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/tipo_comparendo_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class ComparendoAdapter extends ModelAdapter<ComparendoModel, ComparendoDto> {

  final InfraccionAdapter _infraccionAdapter;
  final PersonaAdapter _personaAdapter;

  ComparendoAdapter(this._infraccionAdapter, this._personaAdapter);

  @override
  ComparendoDto fromModel(ComparendoModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  ComparendoModel toModel(ComparendoDto external) {

    EstadoComparendoModel estadoComparendo = EstadoComparendoModel();
    estadoComparendo.descripcion = external.estado.descripcion;
    estadoComparendo.estadoId = external.estado.estadoId;
    estadoComparendo.nombre = external.estado.nombre;

    TipoComparendoModel tipoComparendoModel = TipoComparendoModel();
    tipoComparendoModel.trafficTicketId = external.tipoComparendo.trafficTicketId;
    tipoComparendoModel.nombre = external.tipoComparendo.nombre;
    tipoComparendoModel.descripcion = external.tipoComparendo.descripcion;

    ComparendoModel comparendoModel = ComparendoModel(
      codigo: external.codigo,
      comparendoId: external.comparendoId,
      direccion: external.direccion,
      estado: estadoComparendo,
      fechaHoraInfraccion: external.fechaHoraInfraccion,
      fechaHoraRegistro: external.fechaHoraRegistro,
      infraccion: _infraccionAdapter.toModel(external.infraccion),
      infractor: _personaAdapter.toModel(external.infractor),
      localidad: external.localidad,
      nivelDeAlcohol: external.alcoholLevel,
      numero: external.numero,
      observation: external.observation,
      placa: external.placa,
      propietario: _personaAdapter.toModel(external.propietario),
      tieneReporteAlcolemia: external.reportsAlcolemia,
      tipoComparendo: tipoComparendoModel,
      valor: external.valor,
      velocidad: external.speed
    );
    return comparendoModel;
  }

  List<ComparendoModel> listDtoToModel(List<ComparendoDto> externalList) {
    {
      List<ComparendoModel> listReturn = [];
      if (externalList.isNotEmpty) {
        for (var element in externalList) {
          listReturn.add(toModel(element));
        }
      }
      return listReturn;
    }
  }
}