
import 'package:app_ciudadano/domain/models/accidente/accidente_model.dart';
import 'package:app_ciudadano/domain/models/comparendo/comparendo_fit_model.dart';
import 'package:app_ciudadano/domain/models/news/news_model.dart';
import 'package:app_ciudadano/domain/models/report/report_model.dart';

abstract class GeneralRepository {
  Future<List<NewsModel>> getNews(int pagina, int itemsPorPagina);
  Future<List<ReportModel>> getMyReports(int pagina, int itemsPorPagina);
  Future<ReportModel> sendReport(ReportModel reportModel);
  Future<List<ComparendoFitModel>> getComparendosUsuario();
  Future<List<AccidenteModel>> getAccidentesUsuario();
  Future<bool> sendTokenFirebase(String token);
}