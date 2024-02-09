import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/accidents/accidents_bloc.dart';
import 'package:app_ciudadano/ui/accidents/accidents_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/search_citations.dart';

class AccidentsScreen extends StatefulWidget {
  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();

  AccidentsScreen({Key? key}) : super(key: key);

  @override
  State<AccidentsScreen> createState() => _AccidentsScreenState();
}

class _AccidentsScreenState extends State<AccidentsScreen> {
  bool _value1 = false;
  bool _value2 = false;
  String initialDate = "";
  String finalDate = "";
  final AccidentsBloc _AccidentsBloc = injector.resolve();
  bool onInit = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccidentsBloc, AccidentsState>(
        bloc: _AccidentsBloc,
        listener: (context, state) {},
        builder: (context, state) => () {
              if (!state.initialLoad) {
                onInit = false;
                _AccidentsBloc.getCitations();
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
              if (state.initialLoad && onInit) {
                onInit = true;
                //Navigator.pop(context);
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

  Widget _body(AccidentsState state) {
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            SearchCitations(
              organizationColor: Colors.green,
              title: ('Accidentes'),
              parentTitle: '',
              searchQuery: (value) {
                if (value != "") {
                  _AccidentsBloc.searchCourses(value);
                } else {
                  _AccidentsBloc.getCitations();
                }
              },
              results: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: _cardCitation(state)),
              ),
              hintText: 'Digite el valor a buscar',
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
    }));
  }

  Widget _cardCitation(AccidentsState state) {
    return Container(
      child: ListView.builder(
        itemCount: state.getFilterAccidents.isEmpty
            ? state.getAccidents.length
            : state.getFilterAccidents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 8,
              child: ListTile(
                leading: const Icon(
                  Icons.album,
                  color: Colors.red,
                ),
                title: Text(
                    'N°IPAT: ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].ipatId : state.getFilterAccidents[index].ipatId}'),
                subtitle: Text(
                    'Numero: ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].numero : state.getFilterAccidents[index].numero}\nFecha Accidente: ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].fechaHoraAccidente : state.getFilterAccidents[index].fechaHoraLevantamiento}\nFecha Levantamiento: ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].fechaHoraLevantamiento : state.getFilterAccidents[index].fechaHoraLevantamiento} \nComplemento Direccion : ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].complementoDireccion : state.getFilterAccidents[index].complementoDireccion} \nAño: ${state.getFilterAccidents.isEmpty ? state.getAccidents[index].anio : state.getFilterAccidents[index].anio} '),
              ),
            ),
          );
        },
      ),
    );
  }

  void _removeFilter(BuildContext contexts, AccidentsState state) {
    _AccidentsBloc.initBloc();
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
                                  _AccidentsBloc.filterSearchCourses(
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

  dialog(
      BuildContext context, String mensaje, AccidentsState state, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: color,
        title: const Text('Notificaciones',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(mensaje, textAlign: TextAlign.justify),
        actions: <Widget>[
          ElevatedButton(
              child: const Text("Ok"),
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
                Navigator.pushNamed(context, 'home');
                if (state.emptyInitialResults) {
                  Navigator.pushNamed(context, 'home');
                }
                state.emptyResults = false;
                state.emptyInitialResults = false;
                _body(state);
              }),
        ],
      ),
    );
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
}
