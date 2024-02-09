import 'package:app_ciudadano/domain/models/comparendo/persona_model.dart';

class UserCrendentials {
  late String? accessToken;
  late String? email;
  late List<String>? roles;
  late String? userId;
  late String? tokenUuidNotificationsPush;
  late String? cedulaUsuario;
  late PersonaModel? persona;
  late String? usuario;
  UserCrendentials({
    this.accessToken,
    this.email,
    this.roles,
    this.tokenUuidNotificationsPush,
    this.userId,
    // this.cedulaUsuario = "7697206",
    this.cedulaUsuario,
    this.persona,
    this.usuario
  });
}
