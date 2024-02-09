import 'package:app_ciudadano/ui/complaints/listReport_card.dart';
import 'package:app_ciudadano/ui/complaints/listReport_state.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/ui/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injector.dart';
import '../../utils/search_citations.dart';
import '../report/ireport/ireport_screen.dart';
import '../splash/splash_screen.dart';
import 'listReport_bloc.dart';
import 'dart:io' show Platform, exit;

class ListReportScreen extends StatefulWidget {
  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();

  ListReportScreen({Key? key}) : super(key: key);

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  bool _value1 = false;
  bool _value2 = false;
  String initialDate = "";
  String finalDate = "";
  ScrollController _controller = ScrollController();
  bool onInit = false;
  bool loadInfo = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScrollUpdate);
  }

  final ListReportBloc _listReportBloc = injector.resolve();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListReportBloc, ListReportState>(
        bloc: _listReportBloc,
        listener: (context, state) {},
        builder: (context, state) => () {
              if (!state.initialLoad) {
                _listReportBloc.getComplaints();
                SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => showDialogLoad(),
                );
                return Container();
              }
              if (state.emptyResults && state.emptyInitialResults) {
                SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => dialog(context,
                      "No hay informacion disponible", state, Colors.red[100]!),
                );
                return _body(state);
              }
              if (state.emptyResults) {
                SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => dialog(
                      context,
                      "No se encontraron resultado relacionados al filtro",
                      state,
                      Colors.green[100]!),
                );
                return _body(state);
              }
              if (state.initialLoad && !onInit) {
                onInit = true;
                Navigator.pop(context);
                return _body(state);
              }
              return _body(state);
            }());
  }

  Widget _body(ListReportState state) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SearchCitations(
            organizationColor: Colors.green,
            title: ('Mis Denuncias'),
            parentTitle: '',
            searchQuery: (value) {
              if (value != "") {
                _listReportBloc.searchReports(value);
              }else{
                _listReportBloc.getComplaints();
              }
            },
            results: Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    top: 2,
                  ),
                  child: _cardMyReports(state)),
            ),
            hintText: 'Digite el valor a buscar',
            enabled: _listReportBloc.allComplaints.isEmpty ? false : true,
            alternativeColor: Colors.grey,
            backgroundColor: Colors.white,
            controller: TextEditingController(),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                state.removeFilter
                    ? Row(
                        children: [
                          Text(
                            "Borrar Filtro",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                              onPressed: () => _removeFilter(context, state),
                              icon: const Icon(
                                Icons.highlight_remove,
                                color: Colors.green,
                              )),
                        ],
                      )
                    : Container(),
                Text(
                  'Busqueda por filtro',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () => _showModalBottomSheet(context),
                    icon: const Icon(
                      Icons.content_paste_search_rounded,
                      color: Colors.green,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardMyReports(ListReportState state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 1,
          );
        },
        controller: _controller,
        itemCount: state.getFilterComplaints.isEmpty
            ? state.getComplaints.length
            : state.getFilterComplaints.length,
        //state.isLoading ? state.getComplaints.length + 1 : state.getComplaints.length,
        itemBuilder: (context, index) {
          return ComplaintsCard(
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].imageIdsList!
                : state.getFilterComplaints[index].imageIdsList!,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].createdIn
                : state.getFilterComplaints[index].createdIn,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].id!
                : state.getFilterComplaints[index].id!,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].address!
                : state.getFilterComplaints[index].address!,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].description
                : state.getFilterComplaints[index].description,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index].responseComplaint
                : state.getFilterComplaints[index].responseComplaint,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints
                : state.getFilterComplaints,
            index,
            state.getFilterComplaints.isEmpty
                ? state.getComplaints[index]
                : state.getFilterComplaints[index],
          );
        },
      ),
    );
  }

  dialog(BuildContext context, String mensaje, ListReportState state,
      Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: color,
        title: const Text('Notificaciones',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(mensaje, textAlign: TextAlign.justify),
        actions: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                //change text color of button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 15.0,
              ),
              onPressed: () {
                //Navigator.of(context).pop();
                //Navigator.of(context, rootNavigator: true).pop(context);
                //Navigator.pushReplacementNamed(context, 'home');
                //SystemNavigator.pop();
                Navigator.pop(context);
                //Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen()));
                //Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                if (state.emptyInitialResults) {
                  //Navigator.of(context).pop();
                  //Navigator.of(context, rootNavigator: true).pop(context);
                  //Navigator.pushReplacementNamed(context, 'home');
                  //SystemNavigator.pop();
                  //Navigator.of(context).pop();
                  //1Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                  Navigator.pop(context);
                }
                state.emptyResults = false;
                state.emptyInitialResults = false;
                _body(state);
              },
              child: const Text("Ok")),
        ],
      ),
    );
  }

  void _removeFilter(BuildContext contexts, ListReportState state) {
    _listReportBloc.initBloc();
  }

  void _showModalBottomSheet(BuildContext contexts) {
    showModalBottomSheet(
        context: contexts,
        builder: (contexts) {
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Filtrar resultados',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Ordenar por')),
                    StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return Container(
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: const Text('Reciente - Antiguo'),
                                secondary: const Icon(Icons.code),
                                autofocus: false,
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: _value1,
                                onChanged: (bool? value) => {
                                  setState(() {
                                    if (_value2 == true) {
                                      _value1 = false;
                                    } else {
                                      _value1 = value!;
                                    }
                                  })
                                },
                              ),
                              CheckboxListTile(
                                title: const Text('Antiguo - Reciente'),
                                secondary: const Icon(Icons.code),
                                autofocus: false,
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: _value2,
                                onChanged: (bool? value) => {
                                  setState(() {
                                    if (_value1 == true) {
                                      _value2 = false;
                                    } else {
                                      _value2 = value!;
                                    }
                                  })
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Card(
                      elevation: 8,
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Fecha desde',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            minimumYear: 2010,
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              initialDate = newDateTime.toIso8601String();
                              if (initialDate == "") {
                                initialDate = DateTime.now().toIso8601String();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Fecha hasta',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            minimumYear: 2010,
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              finalDate = newDateTime
                                  .add(const Duration(days: 1))
                                  .toIso8601String();
                              if (finalDate == "") {
                                finalDate = DateTime.now()
                                    .add(const Duration(days: 1))
                                    .toIso8601String();
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar')),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  if (initialDate == "") {
                                    initialDate = DateTime(2005, 1, 1, 0, 0)
                                        .toIso8601String();
                                  }
                                  if (finalDate == "") {
                                    finalDate =
                                        DateTime.now().toIso8601String();
                                  }
                                  _listReportBloc.filterSearchCourses(
                                      initialDate, finalDate, _value1, _value2);
                                  _value1 = false;
                                  _value2 = false;
                                  Navigator.pop(context);
                                },
                                child: const Text('Aceptar'))
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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

  void _onScrollUpdate() {
    ListReportState state = ListReportState();
    print(_controller.offset);
    var maxScroll = _controller.position.maxScrollExtent;
    var currentPosition = _controller.position.pixels;
    if (currentPosition > maxScroll - 10) {
      print('llegamos al final');
      loadInfo = true;
      _listReportBloc.getComplaints();
    }
  }
}
