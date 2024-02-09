import 'package:app_ciudadano/domain/repository/general_repository.dart';
import 'package:app_ciudadano/ui/complaints/listReport_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/report/report_model.dart';

class ListReportBloc extends Cubit<ListReportState> {
  final GeneralRepository _generalRepository;
  List<ReportModel> allComplaints = [];
  int pagina = 0;
  int loadComplaints = 0;
  var newListComplaints = <ReportModel>{};

  ListReportBloc(
    this._generalRepository,
  ) : super(ListReportState());

  void initBloc() async {
    emit(state.copyWith(removeFilter: false, getFilterComplaints: []));
    this.allComplaints = [];
    this.pagina = 0;
    this.loadComplaints = 0;
    getComplaints();
  }

  void getComplaints() async {
    emit(state.copyWith(
      finalList: true,
    ));
    loadComplaints = loadComplaints + 1;
    List<ReportModel> complaints = [];
    bool empty = false;
    pagina = pagina + 1;
    complaints = await _generalRepository.getMyReports(0, 0);
    allComplaints.addAll(complaints);

    if (complaints.isEmpty && loadComplaints == 1) {
      empty = true;
    }
    emit(state.copyWith(
      initialLoad: true,

      //la siguiente linea evita la duplicación de elementos
      getComplaints: allComplaints.where((element) => newListComplaints.add(element)).toList(),
      emptyInitialResults: empty,
      emptyResults: empty,
      finalList: !state.finalList,
    ));
  }

  void letFilter(bool filter) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(letFilter: true));
  }

  void searchReports(String value) {
    bool empty = false;
    List<ReportModel> listFilter = state.getComplaints
        .where((element) =>
            element.id.toString().toUpperCase().contains(value.toUpperCase()) ||
                element.description.toUpperCase().contains(value.toUpperCase()) ||
            element.responseComplaints.contains(value.toUpperCase()) ||
            element.location
                .toString()
                .toUpperCase()
                .contains(value.toUpperCase()) ||
            element.address
                .toString()
                .toUpperCase()
                .contains(value.toUpperCase()))
        .toList();

    if (listFilter.isEmpty) {
      empty = true;
    }
    emit(state.copyWith(
      initialLoad: true,
      getFilterComplaints: listFilter,
      isLoading: !state.isLoading,
      emptyResults: empty,
    ));
  }

  void filterSearchCourses(String fechaInicial, String fechaFinal,
      bool recienteAntg, bool antgReciente) {
    bool noResults = false;
    bool removeFilter = false;
    List<ReportModel> listFilterFinal = [];
    List<ReportModel> listFilter = [];
    final close = DateTime.parse(fechaFinal);
    final open = DateTime.parse(fechaInicial);
    for (var i in state.getComplaints) {
      final actual = DateTime.parse(i.createdIn);
      final noIniciado = actual.difference(close);
      final finalizado = open.difference(actual);
      if (finalizado.isNegative && noIniciado.isNegative) {
        listFilter.add(i);
      }
    }
    if (listFilter.isNotEmpty) {
      removeFilter = true;
    }
    if (listFilter.isEmpty) {
      noResults = true;
    }
    if (recienteAntg) {
      listFilterFinal = _RecienteAntiguo(listFilter);
    } else if (antgReciente || antgReciente == false && recienteAntg == false) {
      listFilterFinal = _AntiguoReciente(listFilter);
    }
    emit(state.copyWith(
        initialLoad: true,
        getFilterComplaints: listFilterFinal,
        resultsFilter: !state.resultsFilter,
        emptyResults: noResults,
        removeFilter: removeFilter));
  }

  List<ReportModel> _RecienteAntiguo(List<ReportModel> fechas) {
    List<ReportModel> fechasRecAnt = fechas;
    fechasRecAnt.sort((b, a) => a.createdIn.compareTo(b.createdIn));
    return fechasRecAnt;
  }

  List<ReportModel> _AntiguoReciente(List<ReportModel> fechas) {
    List<ReportModel> fechasAntRec = fechas;
    fechasAntRec.sort((a, b) => a.createdIn.compareTo(b.createdIn));
    return fechasAntRec;
  }
}
