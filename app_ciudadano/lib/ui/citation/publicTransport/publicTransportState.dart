import 'package:equatable/equatable.dart';

import '../../../domain/models/comparendo/comparendo_fit_model.dart';

class PublicTransportState extends Equatable {
  final bool initialLoad;
  final List<ComparendoFitModel> getCitations;
  final List<ComparendoFitModel> getFilterCitations;
  bool letFilter;
  bool resultsFilter;
  bool emptyResults;
  bool emptyInitialResults;
  bool loadFilter;
  bool removeFilter;

  PublicTransportState( {this.initialLoad = false, this.getCitations = const [], this.getFilterCitations = const [], this.letFilter = false, this.resultsFilter = false, this.emptyResults = false, this.emptyInitialResults = false, this.loadFilter=false, this.removeFilter = false});
  PublicTransportState copyWith({
    bool? initialLoad,
    List<ComparendoFitModel>? getCitations,
    List<ComparendoFitModel>? getFilterCitations,
    bool? letFilter,
    bool? resultsFilter,
    bool? emptyResults,
    bool? emptyInitialResults,
    bool? loadFilter,
    bool? removeFilter
  }) =>
      PublicTransportState(
        initialLoad: initialLoad ?? this.initialLoad,
        getCitations: getCitations ?? this.getCitations,
        getFilterCitations: getFilterCitations ?? this.getFilterCitations,
        letFilter: letFilter ?? this.letFilter,
        resultsFilter: resultsFilter ?? this.resultsFilter,
        emptyResults: emptyResults ?? this.emptyResults,
        emptyInitialResults: emptyInitialResults ?? this.emptyInitialResults,
        loadFilter : loadFilter ?? this.loadFilter,
        removeFilter: removeFilter ?? this.removeFilter
      );

  @override
  List<Object?> get props => [
        initialLoad,
        getCitations,
        getFilterCitations,
        letFilter,
        resultsFilter,
        emptyResults,
        emptyInitialResults,
        loadFilter,
        removeFilter
      ];
}
