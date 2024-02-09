import 'package:app_ciudadano/data/webService/dto/rerport/location_dto.dart';
import 'package:app_ciudadano/data/webService/dto/rerport/report_dto.dart';
import 'package:app_ciudadano/domain/models/report/location_model.dart';
import 'package:app_ciudadano/domain/models/report/report_model.dart';
import 'package:app_ciudadano/domain/util/modelAdapter.dart';

class ReportAdapter extends ModelAdapter<ReportModel, ReportDto> {
  @override
  ReportDto fromModel(ReportModel model) {
    LocationDto locationDto =
        LocationDto(lat: model.location.lat, long: model.location.long);
    ReportDto report = ReportDto(
        creadoEn: model.createdIn,
        usuarioId: model.userId,
        descripcion: model.description,
        mensajeRespuesta: model.responseComplaint,
        imagenes: model.imageIdsList!,
        publicado: model.publish,
        tipoDenunciaId: model.reportTypeId,
        ubicacion: locationDto,
        direccion: model.address,
        idDenuncia: model.id);
    return report;
  }

  @override
  ReportModel toModel(ReportDto external) {
    LocationModel location = LocationModel(
        lat: external.ubicacion.lat, long: external.ubicacion.long);
    ReportModel reportModel = ReportModel(
        createdIn: external.creadoEn,
        description: external.descripcion,
        responseComplaints: external.mensajeRespuesta,
        location: location,
        publish: external.publicado,
        reportTypeId: external.tipoDenunciaId,
        userId: external.usuarioId,
        address: external.direccion,
        id: external.idDenuncia,
        imageIdsList: external.imagenes, responseComplaint: '');
    return reportModel;
  }

  List<ReportModel> listDtoToModel(List<ReportDto> externalList) {
    {
      List<ReportModel> listReturn = [];
      if (externalList.isNotEmpty) {
        for (var element in externalList) {
          listReturn.add(toModel(element));
        }
      }
      return listReturn;
    }
  }
}
