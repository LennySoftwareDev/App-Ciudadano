import 'package:app_ciudadano/ui/accidents/accidents_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/accidente/accidente_model.dart';
import '../../domain/repository/general_repository.dart';

class AccidentsBloc extends Cubit<AccidentsState>{
  final GeneralRepository _generalRepository;
  AccidentsBloc(
    this._generalRepository,
  ) : super(AccidentsState());

   void initBloc() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit( AccidentsState());
  }

  void getCitations() async{
    List<AccidenteModel> accidents = [];
    bool empty = false;
    accidents = await _generalRepository.getAccidentesUsuario();
    if(accidents.isEmpty){
      empty = true;
    }
    emit(state.copyWith(
      getFilterAccidents: [],
      initialLoad: true,
      getAccidents: accidents,
      emptyResults: empty,
      emptyInitialResults: empty,
    ));
  }

    void searchCourses(String value) {
    bool empty = false;
    List<AccidenteModel> listFilter = state.getAccidents
        .where((element) =>
            element.numero
                .toUpperCase()
                .contains(value.toUpperCase()) ||
            element.ipatId.toString()
                .contains(value.toUpperCase()))
        .toList();
    if(listFilter.isEmpty){
      empty = true;
    }
    emit(state.copyWith(
        initialLoad: true,
        getFilterAccidents: listFilter,
        emptyResults: empty,
        loadFilter: !state.loadFilter
        ));
  }
 void filterSearchCourses(String fechaInicial, String fechaFinal, bool recienteAntg, bool antgReciente){
    bool noResults = false;
    bool removeFilter = false;
    List<AccidenteModel> listFilterFinal = [];
    List<AccidenteModel> listFilter = [];
    final close = DateTime.parse(fechaFinal);
    final open = DateTime.parse(fechaInicial);
    for(var i in state.getAccidents){
      final actual = DateTime.parse(i.fechaHoraAccidente);
      final noIniciado = actual.difference(close);
      final finalizado = open.difference(actual);
      if (finalizado.isNegative && noIniciado.isNegative) {
        listFilter.add(i);
      }
    }
    if(listFilter.isNotEmpty){
      removeFilter = true;
    }
    if(listFilter.isEmpty){
      noResults = true;
    }
    if(recienteAntg){
      listFilterFinal= _RecienteAntiguo(listFilter);
    }else if(antgReciente || antgReciente == false && recienteAntg == false){
      listFilterFinal = _AntiguoReciente(listFilter);
    }
    emit(state.copyWith(
        initialLoad: true,
        getFilterAccidents: listFilterFinal,
        resultsFilter: !state.resultsFilter,
        emptyResults : noResults,
        removeFilter: removeFilter
        ));
  }

  List<AccidenteModel> _RecienteAntiguo(List<AccidenteModel> fechas){
    List<AccidenteModel>  fechasRecAnt = fechas;
    fechasRecAnt.sort((b, a) => a.fechaHoraAccidente.compareTo(b.fechaHoraAccidente));
    return fechasRecAnt;
  }

  List<AccidenteModel> _AntiguoReciente(List<AccidenteModel> fechas){
    List<AccidenteModel>  fechasAntRec = fechas;
    fechasAntRec.sort((a, b) => a.fechaHoraAccidente.compareTo(b.fechaHoraAccidente));
    return fechasAntRec;
  }
  
}