import 'package:app_ciudadano/data/webService/api/generalApi.dart';
import 'package:app_ciudadano/domain/models/notificaciones/notificacion_model.dart';
import 'package:app_ciudadano/domain/models/user/user_credentials_model.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import '../../../di/dependency_injector.dart';

class PushNotificationService {
  late FirebaseMessaging messaging = FirebaseMessaging.instance;
    UserCrendentials userCrendentials = injector.resolve();
    final NotificationSidebarBloc _notificationSidebarBloc = injector.resolve();
    final HomeBloc _homeBloc = injector.resolve();
   
  
  Future<void> initializeMessageToken() async {
    await Firebase.initializeApp();
    String token = "";
    try {
      token = await messaging.getToken() ?? '';
      userCrendentials.tokenUuidNotificationsPush = token;
      print(token);
     
   
    } on Exception catch (ex) {
      print("Catched exception: ${ex.toString()}");
    }
    FirebaseMessaging.onBackgroundMessage(_manejadorBackgroud);
    FirebaseMessaging.onMessage.listen(_manejadorAppMensajes);
    FirebaseMessaging.onMessageOpenedApp.listen(_manejadorAppAbierta);
    
  }

  static Future _manejadorBackgroud(RemoteMessage notificacion) async {
    
  }
  Future _manejadorAppMensajes(RemoteMessage notificacion) async {
    sendNotifications(notificacion);
  }
  Future _manejadorAppAbierta(RemoteMessage notificacion) async {
    sendNotifications(notificacion);
  }

  sendNotifications(RemoteMessage notificacion){
    NotificacionModel notificacionNueva = NotificacionModel(titulo: notificacion.notification!.title!, 
    descripcion: notificacion.notification!.body!,
    ulrImg: Platform.isAndroid ? notificacion.notification!.android!.imageUrl!  : notificacion.notification!.apple!.imageUrl!
     );
    
    _notificationSidebarBloc.addNotification(notificacionNueva);
    _homeBloc.emmitNotificaciones();
  }
}