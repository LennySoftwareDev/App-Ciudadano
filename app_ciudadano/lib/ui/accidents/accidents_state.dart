import 'package:equatable/equatable.dart';

import '../../domain/models/accidente/accidente_model.dart';

class AccidentsState extends Equatable{
  final bool initialLoad;
  final List<AccidenteModel> getAccidents;
  final List<AccidenteModel> getFilterAccidents;
  bool resultsFilter;
  bool emptyResults;
  bool emptyInitialResults;
  bool loadFilter;
  bool removeFilter;
 
  AccidentsState( {this.initialLoad = false, this.getAccidents = const [], this.getFilterAccidents = const[], this.resultsFilter = false, this.emptyResults = false, this.emptyInitialResults = false, this.loadFilter=false, this.removeFilter = false});
  AccidentsState copyWith({
    bool? initialLoad,
    List<AccidenteModel>? getAccidents,
    List<AccidenteModel>? getFilterAccidents,
    bool? resultsFilter,
    bool? emptyResults,
    bool? emptyInitialResults,
    bool? loadFilter,
    bool? removeFilter,

  }) =>
      AccidentsState(
        initialLoad: initialLoad ?? this.initialLoad,
        getAccidents: getAccidents ?? this.getAccidents,
        getFilterAccidents: getFilterAccidents ?? this.getFilterAccidents,
        resultsFilter : resultsFilter ?? this.resultsFilter,
        emptyResults: emptyResults ?? this.emptyResults,
        emptyInitialResults: emptyInitialResults ?? this.emptyInitialResults,
        loadFilter: loadFilter ?? this.loadFilter,
        removeFilter: removeFilter ?? this.removeFilter
      );

  @override
  List<Object?> get props => [
        initialLoad,
        getAccidents,
        getFilterAccidents,
        resultsFilter,
        emptyResults,
        emptyInitialResults,
        loadFilter, 
        removeFilter
      ];
  
}