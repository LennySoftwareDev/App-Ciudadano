import 'package:app_ciudadano/connection_status_bloc.dart';
import 'package:app_ciudadano/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WarningWidgetCubit extends StatelessWidget {
  const WarningWidgetCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionStatusBloc(),
      child: BlocBuilder<ConnectionStatusBloc, ConnectionStatus>(
          builder: (context, status) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: 60,
              color: Colors.red,
              child: Row(
                children: const [
                  Icon(Icons.wifi_off),
                SizedBox(width: 8,),
                  Text("Sin conexion a internet",style: TextStyle(color: Colors.white, fontSize: 16))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
  
}
