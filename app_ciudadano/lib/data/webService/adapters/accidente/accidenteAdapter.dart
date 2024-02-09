import 'package:app_ciudadano/data/webService/dto/accident/accidente_dto.dart';
import 'package:app_ciudadano/domain/models/accidente/accidente_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class AccidenteAdapter extends ModelAdapter<AccidenteModel, AccidenteDto> {
  @override
  AccidenteDto fromModel(AccidenteModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  AccidenteModel toModel(AccidenteDto external) {
    AccidenteModel accidenteModel = AccidenteModel(numero: external.numero,
    anio: external.anio, complementoDireccion: external.complementoDireccion,
    fechaHoraAccidente: external.fechaHoraAccidente, 
    fechaHoraLevantamiento: external.fechaHoraLevantamiento, 
    ipatId: external.ipatId);
    return accidenteModel;
  }

   List<AccidenteModel> listDtoToModel(List<AccidenteDto> externalList) {
    {
      List<AccidenteModel> listReturn = [];
      if (externalList.isNotEmpty) {
        for (var element in externalList) {
          listReturn.add(toModel(element));
        }
      }
      return listReturn;
    }
  }
}