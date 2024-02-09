import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/domain/models/notificaciones/notificacion_model.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_bloc.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSidebar extends StatelessWidget {
  final NotificationSidebarBloc _notificationSidebarBloc = injector.resolve();
  NotificationSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NotificationSidebarBloc, NotificationSidebarState>(
        bloc: _notificationSidebarBloc,
        listener: (context, state) {},
        builder: (context, state) => () {
              
              return _bodyPage(state.notificaciones);
            }());
  }
  
  Widget _bodyPage(List<NotificacionModel> notificaciones){
    return Drawer(
      backgroundColor: const Color(0xFFF5F5F5) ,
      child : SingleChildScrollView(
        child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                itemCount: notificaciones.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return cardNotification(notificaciones[index]);
                }),
      )
    );
  }

  Widget cardNotification(NotificacionModel notificacion){
    return Card(
      elevation: 10,
      child: ListTile(
        title: Image.network(notificacion.ulrImg,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notificacion.titulo.toUpperCase()),
          Text(notificacion.descripcion),
          
        ],)
        

      ),
    );
  }
}
