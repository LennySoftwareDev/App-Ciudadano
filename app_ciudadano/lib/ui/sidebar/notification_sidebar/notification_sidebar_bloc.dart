import 'package:app_ciudadano/domain/models/notificaciones/notificacion_model.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSidebarBloc extends Cubit<NotificationSidebarState> {
  List<NotificacionModel> notificaciones = [];
  NotificationSidebarBloc() : super(const NotificationSidebarState());

 
  addNotification(NotificacionModel notificacion){
    notificaciones.add(notificacion);
    emit(state.copyWith(notificaciones: notificaciones));
  }
}
