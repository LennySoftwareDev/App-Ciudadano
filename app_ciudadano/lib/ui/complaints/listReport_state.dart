import 'package:equatable/equatable.dart';

import '../../domain/models/report/report_model.dart';

class ListReportState extends Equatable{
  final bool initialLoad;
  final List<ReportModel> getComplaints;
  final List<ReportModel> getFilterComplaints;
  bool letFilter;
  bool resultsFilter;
  bool emptyResults;
  bool emptyInitialResults;
  bool isLoading;
  bool finalList;
  bool removeFilter;

  ListReportState({this.initialLoad = false, this.getComplaints = const [], this.getFilterComplaints= const [], this.letFilter = false, this.resultsFilter = false, this.emptyResults = false, this.emptyInitialResults = false, this.isLoading = false, this.finalList = false, this.removeFilter = false });
  ListReportState copyWith({
    bool? initialLoad,
    List<ReportModel>? getComplaints,
    List<ReportModel>? getFilterComplaints,
    bool? letFilter,
    bool? resultsFilter,
    bool? emptyResults,
    bool? emptyInitialResults,
    int? currentPage,
    bool? isLoading,
    bool? finalList,
    bool? removeFilter,
  }) =>
      ListReportState(
        initialLoad: initialLoad ?? this.initialLoad,
        getComplaints: getComplaints ?? this.getComplaints,
        getFilterComplaints : getFilterComplaints ?? this.getFilterComplaints,
        letFilter: letFilter ?? this.letFilter,
        resultsFilter: resultsFilter ?? this.resultsFilter,
        emptyResults: emptyResults ?? this.emptyResults,
        emptyInitialResults: emptyInitialResults ?? this.emptyInitialResults,
        isLoading: isLoading ?? this.isLoading,
        finalList: finalList ?? this.finalList,
        removeFilter:removeFilter ?? this.removeFilter,
      
      );

  @override
  List<Object?> get props => [
        initialLoad,
        getComplaints,
        getFilterComplaints,
        letFilter,
        resultsFilter,
        emptyResults,
        emptyInitialResults,
        isLoading,
        finalList,
        removeFilter,
    
      ];
  
}

