
import 'package:app_ciudadano/data/webService/adapters/accidente/accidenteAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/comparendoAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/comparendoFitAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/infraccionAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/comparendo/personaAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/newAdapter.dart';
import 'package:app_ciudadano/data/webService/adapters/reportAdapter.dart';
import 'package:app_ciudadano/data/webService/api/generalApi.dart';
import 'package:app_ciudadano/data/webService/repositoryImpl/general_repository_impl.dart';
import 'package:app_ciudadano/domain/repository/general_repository.dart';
import 'package:app_ciudadano/ui/accidents/accidents_bloc.dart';
import 'package:app_ciudadano/ui/citation/publicTransport/publicTransportBloc.dart';
import 'package:app_ciudadano/ui/citation/transit/transit_bloc.dart';
import 'package:app_ciudadano/ui/complaints/listReport_bloc.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/ui/news/controller/news_bloc.dart';
import 'package:app_ciudadano/ui/report/ireport/ireport_bloc.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_bloc.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:app_ciudadano/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart';

import '../data/database/db/user_db_connection.dart';
import '../data/database/repository/user_repository.dart';
import '../domain/models/user/notifications_service_model.dart';
import '../domain/models/user/user_credentials_model.dart';
import '../domain/models/user/preferenceDb/user_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



final injector = KiwiContainer();
const BASE_URL = "syp-pi-core-ws.azurewebsites.net";

class AppInjector {

  static setUpInjector() async {

    // MODELS

    injector.registerSingleton((container) => UserCrendentials());
    injector.registerSingleton((container) => PushNotificationService());
    injector.registerSingleton((container) => Utils());

    // DB
    Hive.registerAdapter(UserPreferencesAdapter());
    Directory directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);

    Box userPreferencesBox =
        await Hive.openBox(NAME_TABLE_PREFERENCES_USER_);
    injector.registerFactory(
      (container) => UserDBConnection(userPreferencesBox),
    );

     //API
    injector.registerSingleton((container) => GeneralApi(BASE_URL, injector.resolve()));

    //ADAPTERS
    injector.registerSingleton((container) => NewAdapter());
    injector.registerSingleton((container) => ReportAdapter());
    injector.registerSingleton((container) => PersonaAdapter());
    injector.registerSingleton((container) => InfraccionAdapter());
    injector.registerSingleton((container) => ComparendoFitAdapter());
    injector.registerSingleton((container) => ComparendoAdapter(injector.resolve(), injector.resolve()));
    injector.registerSingleton((container) => AccidenteAdapter());

    // REPOSITORIES
    injector.registerFactory(
      (container) => UserRepositoryDB(
        injector.resolve(),
      ),
    );

    injector.registerSingleton<GeneralRepository>((container) => GeneralRepositoryImpl(injector.resolve(), injector.resolve(), injector.resolve(), injector.resolve(), injector.resolve()));

    // BLOCS
   
    injector.registerSingleton(
      (container) => HomeBloc(injector.resolve()),
    );
    injector.registerSingleton(
      (container) => NewsBloc(injector.resolve()),
    );
    injector.registerFactory(
      (container) => IreportBloc(injector.resolve()),
    );
     injector.registerSingleton(
      (container) => TransitBloc(injector.resolve()),
    );
    injector.registerSingleton(
      (container) => PublicTransportBloc(injector.resolve()),
    );
    injector.registerSingleton((container) => NotificationSidebarBloc());

    injector.registerFactory((container) => ListReportBloc(injector.resolve()));

    injector.registerSingleton((container) => AccidentsBloc(injector.resolve()));
  }
}
