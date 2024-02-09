// ignore_for_file: unnecessary_this

import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/citation/publicTransport/publicTransportBloc.dart';
import 'package:app_ciudadano/ui/citation/publicTransport/publicTransportState.dart';
import 'package:app_ciudadano/utils/search_citations.dart';
import 'package:app_ciudadano/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicTransportScreen extends StatefulWidget {
  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();

  PublicTransportScreen({Key? key}) : super(key: key);

  @override
  State<PublicTransportScreen> createState() => _PublicTransportScreenState();
}

class _PublicTransportScreenState extends State<PublicTransportScreen> {
  bool _value1 = false;
  bool _value2 = false;
  String initialDate = "";
  String finalDate = "";
  Utils utils = injector.resolve();

  final PublicTransportBloc _publicTransitBloc = injector.resolve();
  bool onInit = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PublicTransportBloc, PublicTransportState>(
        bloc: _publicTransitBloc,
        listener: (context, state) {},
        builder: (context, state) => () {
              if (!state.initialLoad) {
                onInit = false;
                _publicTransitBloc.getCitations();
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

  Widget _body(PublicTransportState state) {
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
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
            SearchCitations(
              organizationColor: Colors.green,
              title: ('Comparendos de transporte público'),
              parentTitle: '',
              searchQuery: (value) {
                if (value != "") {
                  this._publicTransitBloc.searchTransit(value);
                } else {
                  this._publicTransitBloc.getCitations();
                }
              },
              results: Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: _cardCitation(state)),
              ),
              hintText: 'Digite el valor a buscar',
              alternativeColor: Colors.white,
              backgroundColor: Colors.white,
              controller: TextEditingController(),
            ),
          ],
        ),
      );
    }));
  }

  Widget _cardCitation(PublicTransportState state) {
    return ListView.builder(
      itemCount: state.getFilterCitations.isEmpty
          ? state.getCitations.length
          : state.getFilterCitations.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 8,
          child: ListTile(
            onTap: (() =>
                utils.visualizePDF(state.getCitations[index].pdfUrl, context)),
            trailing: const Icon(
              Icons.remove_red_eye,
              color: Colors.green,
            ),
            title: Text(
                'Numero: ${state.getFilterCitations.isEmpty ? state.getCitations[index].numero : state.getFilterCitations[index].numero}'),
            subtitle: Text(
                'Fecha: ${state.getFilterCitations.isEmpty ? state.getCitations[index].fechaImposicion : state.getFilterCitations[index].fechaImposicion}\nCodigo nuevo: ${state.getFilterCitations.isEmpty ? state.getCitations[index].codigoNuevo : state.getFilterCitations[index].codigoNuevo} \nDescripccion : ${state.getFilterCitations.isEmpty ? state.getCitations[index].descripcion : state.getFilterCitations[index].descripcion} \nTipo de comparendo: ${state.getFilterCitations.isEmpty ? state.getCitations[index].tipoComparendo : state.getFilterCitations[index].tipoComparendo}  \nValor: ${state.getFilterCitations.isEmpty ? state.getCitations[index].valor : state.getFilterCitations[index].valor} '),
          ),
        );
      },
    );
  }

  void _removeFilter(BuildContext contexts, PublicTransportState state) {
    _publicTransitBloc.initBloc();
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
                              this.initialDate = newDateTime.toIso8601String();
                              if (this.initialDate == "") {
                                this.initialDate =
                                    DateTime.now().toIso8601String();
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
                              this.finalDate = newDateTime
                                  .add(const Duration(days: 1))
                                  .toIso8601String();
                              if (this.finalDate == "") {
                                this.finalDate = DateTime.now()
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
                                  if (this.initialDate == "") {
                                    this.initialDate =
                                        DateTime(2005, 1, 1, 0, 0)
                                            .toIso8601String();
                                  }
                                  if (this.finalDate == "") {
                                    this.finalDate =
                                        DateTime.now().toIso8601String();
                                  }
                                  _publicTransitBloc.filterSearchCourses(
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

  dialog(BuildContext context, String mensaje, PublicTransportState state,
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
              child: const Text("Ok"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
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
