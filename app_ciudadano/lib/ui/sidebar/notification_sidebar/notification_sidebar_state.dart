import 'package:app_ciudadano/domain/models/notificaciones/notificacion_model.dart';
import 'package:equatable/equatable.dart';

class NotificationSidebarState extends Equatable {

  final List<NotificacionModel> notificaciones;

  const NotificationSidebarState({this.notificaciones = const []});

  @override
  List<Object?> get props => [notificaciones];

  NotificationSidebarState copyWith({
    List<NotificacionModel>? notificaciones,
  }) {
    return NotificationSidebarState(
      notificaciones: notificaciones ?? this.notificaciones,
    );
  }
}