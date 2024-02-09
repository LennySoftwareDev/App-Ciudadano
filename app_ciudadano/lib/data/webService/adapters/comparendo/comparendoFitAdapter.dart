
import 'package:app_ciudadano/data/webService/dto/comparendo/comparendo_fit_dto.dart';
import 'package:app_ciudadano/domain/models/comparendo/comparendo_fit_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class ComparendoFitAdapter extends ModelAdapter<ComparendoFitModel, ComparendoFitDto> {


  ComparendoFitAdapter();
  @override
  ComparendoFitDto fromModel(ComparendoFitModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  ComparendoFitModel toModel(ComparendoFitDto external)  => ComparendoFitModel(
    codigoNuevo: external.codigoNuevo,
    descripcion: external.descripcion,
    fechaImposicion: external.fechaHoraInfraccion,
    numero: external.numero,
    tipoComparendo: external.tipoComparendo,
    valor: external.valor,
    pdfUrl: external.pdfUrl
    );

  List<ComparendoFitModel> listDtoToModel(List<ComparendoFitDto> externalList) {
    {
      List<ComparendoFitModel> listReturn = [];
      if (externalList.isNotEmpty) {
        for (var element in externalList) {
          listReturn.add(toModel(element));
        }
      }
      return listReturn;
    }
  }
}