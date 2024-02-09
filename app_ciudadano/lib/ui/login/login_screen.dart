
import 'package:app_ciudadano/data/database/repository/user_repository.dart';
import 'package:app_ciudadano/data/webService/api/generalApi.dart';
import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/domain/models/comparendo/persona_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:pkce/pkce.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';
import '../../domain/models/user/user_credentials_model.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  UserCrendentials userCrendentials = injector.resolve();
  final UserRepositoryDB _userRepositoryDB = injector.resolve();
   final GeneralApi _generalApi = injector.resolve();

  bool isLogin = false;
  bool checkedWalkthrough = false;

  @override
  Widget build(BuildContext context) {
        return Center(
          child: isLogin
              ? ElevatedButton(
                  onPressed: () => {},
                  child: const Text(''),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: createClientWeb(), //
                      child: Text(
                        "Iniciar Sesion",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
        );
    
  }

  createClientWeb() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      final pkcePair = PkcePair.generate();

      final authorizationEndpoint =
          Uri.parse("https://pi-ids.azurewebsites.net/connect/authorize");
      final tokenEndpoint =
          Uri.parse("https://pi-ids.azurewebsites.net/connect/token");
      const identifier = "syp.pi.core.web.client";
      final redirectUrl = Uri.parse("https://oauth.pstmn.io/v1/callback");
      var grant = oauth2.AuthorizationCodeGrant(
          identifier, authorizationEndpoint, tokenEndpoint,
          basicAuth: true,
          secret: "secret",
          codeVerifier: pkcePair.codeVerifier);

      final scope = ["openid", "profile", "email", "offline_access", "syp.pi.core.api"];

      var authorizationUrl =
          grant.getAuthorizationUrl(redirectUrl, scopes: scope);
      late Uri responseUrl;

      await Navigator.push(
        context,
        MaterialPageRoute(
          maintainState: true,
          builder: (_) {
            return SafeArea(
              child: WebView(
                onWebResourceError: (WebResourceError webviewerrr) => {},
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: authorizationUrl.toString(),
                navigationDelegate: (navigationRequest) {
                  if (navigationRequest.url
                      .startsWith(redirectUrl.toString())) {
                    responseUrl = Uri.parse(navigationRequest.url);
                    Navigator.pop(context);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            );
          },
        ),
      );

      Client clienteAuth =
          await grant.handleAuthorizationResponse(responseUrl.queryParameters);
      saveCredentials(clienteAuth);
    });
  }

  saveCredentials(Client clienteAuth) async{
    Map<String, dynamic> payload =
        Jwt.parseJwt(clienteAuth.credentials.accessToken);
    String accessToken = clienteAuth.credentials.accessToken;
   
    String email = payload['email'];
    String userData = payload['user-data'];
    dynamic userDataJson =json.decode(userData);
    PersonaModel personaData = PersonaModel(
      numerodocumento: userDataJson['Persona']['Identificacion'],
      primerNombre: userDataJson['Persona']['PrimerNombre'],
      segundoNombre: userDataJson['Persona']['SegundoNombre'],
      apellidoPaterno: userDataJson['Persona']['ApellidoPaterno'],
      apellidoMaterno: userDataJson['Persona']['ApellidoMaterno'],
      correoElectronico: payload['email'],
      telefonoCelular: userDataJson['Persona']['TelefonoCelular'],
      tipoDocumento: userDataJson['Persona']['TipoDocumentoId']
      );
     int userId =  userDataJson['UsuarioId'];
    userCrendentials.usuario = userDataJson["Username"];
    userCrendentials.persona = personaData;
    //List<String> roles = List<String>.from(payload['role']);
    userCrendentials.accessToken = accessToken;
    userCrendentials.email = email;
    //userCrendentials.roles = roles;
    userCrendentials.userId = userId.toString();
    isLogin = true; 
    await _generalApi.sendTokenFirebase(userCrendentials.tokenUuidNotificationsPush!);
    bool showWalkThroug = !_userRepositoryDB.checkWalkthroughWatched();
    if (showWalkThroug){
      Navigator.pushReplacementNamed(context, "walkthrough");
    }else{
      Navigator.pushReplacementNamed(context, "home");
    }
  }
}
