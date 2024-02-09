import 'dart:convert';
import 'dart:io';
import 'package:app_ciudadano/ui/report/ireport/ireport_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/report/report_model.dart';
import '../../../domain/repository/general_repository.dart';

class IreportBloc extends Cubit<IreportState> {

  final GeneralRepository _generalRepository;
  IreportBloc(this._generalRepository) : super(const IreportState());

  Future<bool> checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      //1 0
      final isEnable = (event.index == 1) ? true : false;
      print('Service status $isEnable'); //disparar eventos
    });
    emit(state.copyWith(
      isLocationEnable: isEnable,
      initialLoad: true,
    ));

    return isEnable;
  }

  void initBloc() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(const IreportState());
  }

  void selectImages() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      files.addAll(state.files);
      emit(state.copyWith(
        files: files,
      ));
    } else {
      // User canceled the picker
    }
  }

  void takeImage() async {
    XFile? file = 
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (file != null) {
       File selectedImage = File(file!.path);
        List<File> files = [];
        files.addAll(state.files);
        files.add(selectedImage);

        emit(state.copyWith(
          files: files,
        ));
    }
   
  }

  void deleteImage(String file) {
    List<File> removeFile = [];
    removeFile.addAll(state.files);
    for (int i = 0; i < removeFile.length; i++) {
      if (removeFile[i].path == file) {
        removeFile.removeAt(i);
      }
    }
    emit(state.copyWith(
      files: removeFile,
    ));
  }

  Future<List<String>> convertImages (List<File> allImages) async{
    List<String> convertIdFiles = [];
    //recorrer lista archivos y creo lista base64 - para guardarlo en imageIdsList
    for(var i in state.files){
      var bytes = i.readAsBytesSync();
      var base64 = base64Encode(bytes);
      convertIdFiles.add(base64);
    }
    return convertIdFiles;
  }

  Future<bool> sendReport(ReportModel reportModel) async {
    bool confirmacion = false;
    reportModel = await _generalRepository.sendReport(reportModel);
    confirmacion = reportModel.id != null;
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(
      isPublished: confirmacion,
      report: reportModel,
    ));
    return confirmacion;
  }
}
