import 'dart:io';

import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/domain/models/report/location_model.dart';
import 'package:app_ciudadano/domain/models/report/report_model.dart';
import 'package:app_ciudadano/ui/report/ireport/ireport_bloc.dart';
import 'package:app_ciudadano/ui/report/ireport/ireport_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../domain/models/user/user_credentials_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/ubication.dart';
import '../../complaints/listReport_screen.dart';
import '../../home/home_bloc.dart';

class IReportScreen extends StatefulWidget {
  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();
  IReportScreen({Key? key}) : super(key: key);

  @override
  State<IReportScreen> createState() => _IReportScreenState();
}

class _IReportScreenState extends State<IReportScreen> {
  final myControllerAdress = TextEditingController();
  final HomeBloc _homeBloc = injector.resolve();
  final myControllerDescription = TextEditingController();
  final myControllerResponseComplaints = TextEditingController();
  final myControllerReport = TextEditingController();
  int typeOfReport = 0;
  bool cancel = false;
  String dropdownValue = 'Tipo denuncia 1';
  bool onInit = false;
  bool validate = false;
  final IreportBloc _ireportBloc = injector.resolve();
  UserCrendentials userCrendentials = injector.resolve();
  @override
  void dispose() {
    myControllerAdress.dispose();
    myControllerDescription.dispose();
    myControllerResponseComplaints.dispose();
    myControllerReport.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IreportBloc, IreportState>(
        bloc: _ireportBloc,
        listener: (context, state) {},
        builder: (context, state) => () {
              if (!state.initialLoad) {
                _ireportBloc.checkGpsStatus();
                SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => showDialogLoad(),
                );
                return Container();
              }
              if (state.initialLoad && !onInit) {
                onInit = true;
                Navigator.pop(context);
                return _body(state);
              }
              if (state.isPublished == true) {
                SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => dialog(context, "Reporte guardado exitosamente \nId : ${state.report!.id} \nDescripccion: ${state.report!.description} \nDireccion: ${state.report!.address}", state, Colors.green[100]!, cancel),
                );
                return _body(state);
              }
              return _body(state);
            }());
  }

  Widget _body(IreportState state) {
    return ListView(
      children: [
        const Text(
          'Aquí podrás realizar tus denuncias que concierne a la secretaria de tránsito y/o transporte de Neiva. Como lo son daños en calle, semaforos averiados, reductores sin pintar, entre otras cosas.',
          textAlign: TextAlign.justify,
        ),
        const Padding(
          padding: EdgeInsets.only(
            bottom: 15,
            top: 10,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Form(
              key: widget._mainInfoFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppConstants.report.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        readOnly: false,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'Dirección',
                          errorText: (validate  && myControllerAdress.text.isEmpty) ? "Obligatorio" : null,
                        ),
                        controller: myControllerAdress,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 7,
                        readOnly: false,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'Descripcción',
                          errorText: (validate  && myControllerDescription.text.isEmpty) ? "Obligatorio" : null,
                        ),
                       
                        controller: myControllerDescription,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      top: 10,
                    ),
                  ),
                  _reportList(),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      top: 10,
                    ),
                  ),
                  SizedBox(
                      height: 70,
                      width: 80,
                      child: state.files.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(0),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.files.length,
                              itemBuilder: (context, index) {
                                List<String> name =
                                    state.files[index].path.split('/');
                                return ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        name[6] == "file_picker"
                                            ? name[7]
                                            : name[6],
                                      ),
                                    ),
                                    trailing: IconButton(
                                        alignment: Alignment.topRight,
                                        icon: const Icon(Icons.close),
                                        onPressed: () => {
                                              _ireportBloc.deleteImage(
                                                  state.files[index].path)
                                            }));
                              },
                            )),
                  ElevatedButton(
                      onPressed: () {
                        _showModalBottomSheet(context);
                      },
                      child: const Text('Adjuntar imágenes')),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      top: 5,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[700], // background
                            // foreground
                          ),
                          onPressed: () {
                            cancel = true;
                            dialog(context, "¿Desea cancelar el proceso?",state, Colors.red[100]!, cancel);
                            
                          },
                          child: const Text('Cancelar')),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 150,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if(state.files.isEmpty ||myControllerDescription.text.isEmpty || myControllerAdress.text.isEmpty){
                             setState(() {
                                validate = true;
                             });
                             if(state.files.isEmpty){
                               dialog(context, "Debes adjuntar al menos una imagen y llenar campos obligatorios (si corresponde)",state, Colors.red[100]!, cancel);
                             }else{
                               dialog(context, "Para realizar el registro debe diligenciar los datos correspondientes",state, Colors.red[100]!, cancel);
                             }
                              
                            }
                            else{
                              SchedulerBinding.instance!.addPostFrameCallback(
                              (timeStamp) => showDialogLoad(),
                            );
                              saveReport(state);
                            }
                          },
                          child: const Text('Enviar')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  void saveReport(IreportState state) async {
    List<String> convertImages = [];
    bool isPublished;
    UbicacionUtil ubicacion = UbicacionUtil();
    Position posicion = await ubicacion.determinePosition();
    DateTime date = DateTime.now();
    String description = myControllerDescription.text;
    String address = myControllerAdress.text;
    int reportTypeId = typeOfReport == 0 ? 1 : typeOfReport;
    List<File> files = state.files;
    LocationModel ubications =
        LocationModel(lat: posicion.latitude, long: posicion.longitude);
    convertImages = await _ireportBloc.convertImages(state.files);
    ReportModel report = ReportModel(
        userId: userCrendentials.email!,
        description: description,
        createdIn: date.toString(),
        publish: true,
        reportTypeId: reportTypeId,
        location: ubications,
        address: address,
        imagesList: files,
        imageIdsList: convertImages, responseComplaints: '', responseComplaint: '');
        
    _ireportBloc.sendReport(report);
  }

  Widget _reportList() {
    return Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: Colors.grey)),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
             underline: Container(),
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Colors.grey),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                typeOfReport = dropdownValue == 'Tipo denuncia 1'
                    ? 1
                    : dropdownValue == 'Tipo denuncia 2'
                        ? 2
                        : dropdownValue == 'Tipo denuncia 3'
                            ? 3
                            : 1;
              });
            },
            items: <String>[
              'Tipo denuncia 1',
              'Tipo denuncia 2',
              'Tipo denuncia 3',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 17, color: Colors.black54),
                ),
              );
            }).toList(),
          ),
        ));
  }

  showDialogLoad() {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) => Container(
              child: Material(
                color: Colors.red.withOpacity(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              ),
            ));
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                ),
                title: const Text('Camara'),
                onTap: () {
                  Navigator.pop(context);
                  _ireportBloc.takeImage();
                },
              ),
              ListTile(
                  leading: const Icon(
                    Icons.photo,
                    color: Colors.green,
                  ),
                  title: const Text('Galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    _ireportBloc.selectImages();
                  }),
            ],
          );
        });
  }

  void showCustomDialog(BuildContext context, String ruta) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(ruta)),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'hola',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

 dialog(BuildContext context, String mensaje, IreportState state, Color color , bool cancel) {
   
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: color,
        title: const Text('Notificaciones', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(mensaje,textAlign: TextAlign.justify),
        actions: <Widget>[
          ElevatedButton(
              child: const Text("Ok"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, //change background color of button
                onPrimary: Colors.white, //change text color of button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 15.0,
              ),
              onPressed: () {
                if(state.isPublished){
                  Navigator.pop(context);
                  _homeBloc.setCurrentSection(AppConstants.sectionComplain);
                }
                if(cancel){
                  //Navigator.pop(context);
                  Navigator.pop(context);
                  myControllerAdress.text = "";
                  myControllerDescription.text = "";
                  myControllerReport.text = "";
                  dropdownValue = 'Tipo denuncia 1';
                  onInit = false;
                  this.cancel = false;
                  _ireportBloc.initBloc();
                }else{
                  Navigator.pop(context);
                 _body(state);
                }
              }),
        ],
      ),
    );
  }
}
