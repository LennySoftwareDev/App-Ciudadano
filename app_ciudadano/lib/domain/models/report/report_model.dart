import 'dart:io';

import 'package:app_ciudadano/domain/models/report/location_model.dart';

class ReportModel {
  int? id;
  String userId;
  String description;
  String responseComplaints;
  String createdIn;
  bool publish;
  int reportTypeId;
  LocationModel location;
  String? address;
  String responseComplaint;
  List<File>? imagesList;
  List<String>? imageIdsList; // este atributo puede cambiar segun implementacion de back
  ReportModel({
    this.id,
    required this.userId,
    required this.description,
    required this.responseComplaints,
    required this.createdIn,
    required this.publish,
    required this.reportTypeId,
    required this.location,
    this.address,
    required this.responseComplaint,
    this.imagesList,
    this.imageIdsList,
  });
}
