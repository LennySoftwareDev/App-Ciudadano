import 'package:app_ciudadano/ui/citation/publicTransport/publicTransportState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/comparendo/comparendo_fit_model.dart';
import '../../../domain/repository/general_repository.dart';

class PublicTransportBloc extends Cubit<PublicTransportState> {
  final GeneralRepository _generalRepository;
  PublicTransportBloc(
    this._generalRepository,
  ) : super(PublicTransportState());

  void initBloc() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit( PublicTransportState());
  }

  void getCitations() async{
    List<ComparendoFitModel> citations = [];
    List<ComparendoFitModel>? publicTransport = [];
    bool empty = false;
    citations = await _generalRepository.getComparendosUsuario();
    if(citations.isEmpty){
      empty=true;
    }
    for(var i in citations){
      String type = 'Transporte público';
      if(i.tipoComparendo.toString() == type.toString()){
        publicTransport.add(i);
      }
    }
    emit(state.copyWith(
      getFilterCitations: [],
      initialLoad: true,
      getCitations: publicTransport,
      emptyResults: empty,
      emptyInitialResults: empty,
    ));
  }

    void searchTransit(String value) {
      bool empty = false;
    List<ComparendoFitModel> listFilter = state.getCitations
        .where((element) =>
            element.numero
                .toUpperCase()
                .contains(value.toUpperCase()) ||
            element.descripcion
                .toUpperCase()
                .contains(value.toUpperCase()) ||
            element.codigoNuevo
                .toUpperCase()
                .contains(value.toUpperCase()))
        .toList();
    if(listFilter.isEmpty){
      empty = true;
    }
    emit(state.copyWith(
        initialLoad: true,
        getFilterCitations: listFilter,
        loadFilter: !state.loadFilter,
        emptyResults: empty,
        ));
  }
  void filterSearchCourses(String fechaInicial, String fechaFinal, bool recienteAntg, bool antgReciente){
    bool noResults = false;
    bool removeFilter = false;
    List<ComparendoFitModel> listFilterFinal = [];
    List<ComparendoFitModel> listFilter = [];
    final close = DateTime.parse(fechaFinal);
    final open = DateTime.parse(fechaInicial);
    for(var i in state.getCitations){
      final actual = DateTime.parse(i.fechaImposicion);
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
        getFilterCitations: listFilterFinal,
        resultsFilter: !state.resultsFilter,
        emptyResults : noResults,
        removeFilter: removeFilter
        ));
  }

  List<ComparendoFitModel> _RecienteAntiguo(List<ComparendoFitModel> fechas){
    List<ComparendoFitModel>  fechasRecAnt = fechas;
    fechasRecAnt.sort((b, a) => a.fechaImposicion.compareTo(b.fechaImposicion));
    return fechasRecAnt;
  }

  List<ComparendoFitModel> _AntiguoReciente(List<ComparendoFitModel> fechas){
    List<ComparendoFitModel>  fechasAntRec = fechas;
    fechasAntRec.sort((a, b) => a.fechaImposicion.compareTo(b.fechaImposicion));
    return fechasAntRec;
  }

  }
