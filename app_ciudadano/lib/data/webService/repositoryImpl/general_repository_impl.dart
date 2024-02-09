

import 'package:app_ciudadano/data/webService/adapters/accidente/accidenteAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/comparendoFitAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/newAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/reportAdapter.dart';
import 'package:app_ciudadano/data/webService/api/generalApi.dart';
import 'package:app_ciudadano/data/webService/dto/accident/accidente_dto.dart';
import 'package:app_ciudadano/data/webService/dto/comparendo/comparendo_fit_dto.dart';
import 'package:app_ciudadano/data/webService/dto/news/new_dto.dart';
import 'package:app_ciudadano/data/webService/dto/rerport/report_dto.dart';
import 'package:app_ciudadano/domain/models/accidente/accidente_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/comparendo_fit_model.dart';
import 'package:app_ciudadano/domain/models/news/news_model.dart';
import 'package:app_ciudadano/domain/models/report/report_model.dart';
import 'package:app_ciudadano/domain/repository/general_repository.dart';

class GeneralRepositoryImpl implements GeneralRepository {

  final GeneralApi _generalApi;
  final NewAdapter _newAdapter;
  final ReportAdapter _reportAdapter;
  final ComparendoFitAdapter _comparendoFitAdapter;
  final AccidenteAdapter _accidenteAdapter;

  GeneralRepositoryImpl(this._generalApi, this._newAdapter, this._reportAdapter,this._comparendoFitAdapter, this._accidenteAdapter);
  @override
  Future<List<NewsModel>> getNews(int pagina, int itemsPorPagina) async {
    List<NewDto> listDto = await _generalApi.getNewAll(pagina, itemsPorPagina);
    return _newAdapter.listDtoToModel(listDto);
  }

  @override
  Future<List<ReportModel>> getMyReports(int pagina, int itemsPorPagina) async {
    List<ReportDto> listDto = await _generalApi.getMyReports(pagina, itemsPorPagina);
    return _reportAdapter.listDtoToModel(listDto);
  }

  @override
  Future<ReportModel> sendReport(ReportModel reportModel) async{
    ReportDto report = _reportAdapter.fromModel(reportModel);
    ReportDto reportReturn = await _generalApi.sendReport(report);
    reportModel.id = reportReturn.idDenuncia;
    return reportModel;
  }

  @override
  Future<List<ComparendoFitModel>> getComparendosUsuario() async {
    List<ComparendoFitDto> listComparendos = await _generalApi.getComparendosUsuario();
    return _comparendoFitAdapter.listDtoToModel(listComparendos);
  }

  @override
  Future<List<AccidenteModel>> getAccidentesUsuario() async{
    List<AccidenteDto> list = await _generalApi.getAccidentesUsuario();
    return _accidenteAdapter.listDtoToModel(list);
  }
  
  @override
  Future<bool> sendTokenFirebase(String token) async {
    bool save = await _generalApi.sendTokenFirebase(token);
    return save;
  }
}