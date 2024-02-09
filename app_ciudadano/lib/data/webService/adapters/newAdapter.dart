import 'package:app_ciudadano/data/webService/dto/news/new_dto.dart';
import 'package:app_ciudadano/domain/models/news/news_model.dart';

import '../../../domain/util/modelAdapter.dart';

class NewAdapter extends ModelAdapter<NewsModel, NewDto> {
  @override
  NewDto fromModel(NewsModel model) {
    // TODO: implement fromModel
    throw UnimplementedError();
  }

  @override
  NewsModel toModel(NewDto external) {
    NewsModel newsModel = NewsModel();
    newsModel.newsID = external.idNovedad.toString();
    newsModel.typeNewsId = external.tipoNovedadId.toString();
    newsModel.name = external.nombre;
    newsModel.creationDate = DateTime.parse(external.creadoEn);
    newsModel.publishedDate = DateTime.parse(external.publicadoEn);
    newsModel.isPublished = external.publicado;
    newsModel.description = external.descripcion;
    newsModel.userID = external.usuarioId;
    newsModel.listImg = external.imagenes;

    return newsModel;
  }

  List<NewsModel> listDtoToModel(List<NewDto> externalList) {
    {
      List<NewsModel> listReturn = [];
      if (externalList.isNotEmpty) {
        for (var element in externalList) {
          listReturn.add(toModel(element));
        }
      }
      return listReturn;
    }
  }
}