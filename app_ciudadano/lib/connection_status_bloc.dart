import 'dart:async';

import 'package:app_ciudadano/main.dart';
import 'package:app_ciudadano/utils/check_internet_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionStatusBloc extends Cubit<ConnectionStatus>{
  late StreamSubscription _connectionSubscription;
  ConnectionStatusBloc(): super(ConnectionStatus.online){
    _connectionSubscription = internetChecker.internetStatus().listen(emit);

  }

  @override
  Future<void> close(){
    _connectionSubscription.cancel();
    return super.close();
  }

}