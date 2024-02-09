import 'dart:io';
import 'package:app_ciudadano/domain/models/report/report_model.dart';
import 'package:equatable/equatable.dart';

class IreportState extends Equatable {
  final String location;
  final bool isLocationEnable;
  final bool initialLoad;
  final String currentLocation;
  final List<File> files;
  final List<String> idFiles;
  final bool isPublished;
  final ReportModel? report;
 
 
  const IreportState({
    this.location = "",
    this.isLocationEnable = false,
    this.initialLoad = false,
    this.currentLocation = '',
    this.files = const [],
    this.isPublished = false,
    this.idFiles=const [],
    this.report,
  }
  );
 
  IreportState copyWith({
    String? location,
    bool? isLocationEnable,
    bool? initialLoad,
    String? currentLocation,
    List<File>? files,
    bool? isPublished,
    List<String>? idFiles,
    ReportModel? report,

  }) =>
      IreportState(
        location: location ?? this.location,
        isLocationEnable: isLocationEnable ?? this.isLocationEnable,
        initialLoad: initialLoad ?? this.initialLoad,
        currentLocation: currentLocation ?? this.currentLocation,
        files: files ?? this.files,
        isPublished: isPublished ?? this.isPublished,
        idFiles: idFiles ?? this.idFiles,
        report: report ?? this.report
      );


  @override
  List<Object?> get props => [
        location,
        isLocationEnable,
        initialLoad,
        currentLocation,
        files,
        isPublished,
        idFiles,
        report
      ];
}