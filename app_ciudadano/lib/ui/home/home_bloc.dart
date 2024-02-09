import 'package:app_ciudadano/ui/home/home_state.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  final NotificationSidebarBloc _notificationSidebarBloc;
  HomeBloc(
    this._notificationSidebarBloc
  ) : super(const HomeState());

  void initData() async{
  }

  void emmitNotificaciones(){
    emit(state.copyWith(countNotifications: _notificationSidebarBloc.notificaciones.length));
  }

  void setCurrentSection(String section) =>
      emit(state.copyWith(appSection: section));
}
