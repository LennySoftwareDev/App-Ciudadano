import 'dart:convert';
import 'package:app_ciudadano/data/webService/dto/accident/accidente_dto.dart';
import 'package:app_ciudadano/data/webService/dto/comparendo/comparendo_fit_dto.dart';
import 'package:app_ciudadano/data/webService/dto/news/new_dto.dart';
import 'package:app_ciudadano/data/webService/dto/rerport/report_dto.dart';
import 'package:app_ciudadano/domain/models/user/user_credentials_model.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:http/http.dart' as http;

class GeneralApi {
  static const String GET_NEWS = "/landingPage/Novedad/GetAll";
  static const String POST_SAVE_REPORT = "/landingPage/Denuncia/Create";
  static const String GET_COMPARENDOS_CON_CEDULA =
      "/traffic-tickets/Comparendo/GetTrafficTicketByTypeAndCC/{tipodocumento}/{cedula}"; //76099855
  static const String POST_MY_REPORTS =
      "/landingPage/Denuncia/SearchMatching/"; //
  static const String GET_ACCIDENTES_CON_CEDULA =
      "/sircat/Ipat/GetIpatsbyIdentification/{cedula}";
  static const String SEND_TOKEN_FIREBASE = "/cross/UsuarioToken/Create";

  final String _baseUrl;
  final UserCrendentials _userCrendentials;

  GeneralApi(this._baseUrl, this._userCrendentials);

  Future<List<NewDto>> getNewAll(int pagina, int itemsPorPagina) async {
    var url = Uri.https(_baseUrl, "$GET_NEWS/$pagina/$itemsPorPagina");
    MyHttpResponse response = await getRequest(url);
    List<NewDto> listReturn = [];
    if (response.statusCode == 200 && response.data != null) {
      try {
        listReturn = NewDto.listMapToListDto(response.data['novedadDtos']);
      } catch (e) {
        print(e);
      }
    }
    return listReturn;
  }

  Future<ReportDto> sendReport(ReportDto report) async {
    var url = Uri.https(_baseUrl, POST_SAVE_REPORT);
    MyHttpResponse response = await postRequest(url,
        jsonMap: report.toMap(),
        additionalHeaders: {
          AUTORIZATION: "Bearer ${_userCrendentials.accessToken!}"
        });
    ReportDto reportReturn = report;
    if (response.statusCode == 200) {
      reportReturn = ReportDto.fromMap(response.data);
    }
    return reportReturn;
  }

  Future<bool> sendTokenFirebase(String token) async {
    var url = Uri.https(_baseUrl, SEND_TOKEN_FIREBASE);
    var body = {
      "usuarioTokenId": 0,
      "token": token,
      "usuarioId": _userCrendentials.userId,
      "userName": _userCrendentials.email
    };
    MyHttpResponse response = await postRequest(url,
        jsonMap: body,
        additionalHeaders: {
          AUTORIZATION: "Bearer ${_userCrendentials.accessToken!}"
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ReportDto>> getMyReports(int pagina, int itemsPorPagina) async {
    var url = Uri.https(_baseUrl, POST_MY_REPORTS);
    var body = {
      "page": pagina,
      "recordsPage": itemsPorPagina,
      "usuarioId": _userCrendentials.email
    };
    MyHttpResponse response = await postRequest(url,
        jsonMap: body,
        additionalHeaders: {
          AUTORIZATION: "Bearer ${_userCrendentials.accessToken!}"
        });
    List<ReportDto> listReturn = [];
    if (response.statusCode == 200 && response.data != null) {
      listReturn = ReportDto.listMapToListDto(response.data['denunciaDtos']);
    }
    return listReturn;
  }

  Future<List<ComparendoFitDto>> getComparendosUsuario() async {
    String urlEndpoint = GET_COMPARENDOS_CON_CEDULA
        .replaceAll("{cedula}", _userCrendentials.persona!.numerodocumento)
        .replaceAll("{tipodocumento}",
            _userCrendentials.persona!.tipoDocumento.toString());
    var url = Uri.https(_baseUrl, urlEndpoint);
    MyHttpResponse response = await getRequest(url, additionalHeaders: {
      AUTORIZATION: "Bearer ${_userCrendentials.accessToken!}"
    });
    List<ComparendoFitDto> listReturn = [];
    if (response.statusCode == 200 && response.data != null) {
      listReturn = ComparendoFitDto.listMapToListDto(
          response.data['listTrafficTicketDto']);
    }
    return listReturn;
  }

  Future<List<AccidenteDto>> getAccidentesUsuario() async {
    String urlEndpoint = GET_ACCIDENTES_CON_CEDULA.replaceAll(
        "{cedula}", _userCrendentials.persona!.numerodocumento);
    var url = Uri.https(_baseUrl, urlEndpoint);
    MyHttpResponse response = await getRequest(url, additionalHeaders: {
      AUTORIZATION: "Bearer ${_userCrendentials.accessToken!}"
    });
    List<AccidenteDto> listReturn = [];
    if (response.statusCode == 200 && response.data != null) {
      listReturn = AccidenteDto.listMapToListDto(response.data);
    }
    return listReturn;
  }

// metodos genericos para hacer las peticiones
  Future<MyHttpResponse> postRequest(Uri uri,
      {bool shouldRetry = true,
      Map? jsonMap,
      Map<String, String>? additionalHeaders,
      bool mntFlag = true}) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };

    if (additionalHeaders != null) {
      headers = {
        ...headers,
        ...additionalHeaders,
      };
    }
    try {
      var response =
          await http.post(uri, body: json.encode(jsonMap), headers: headers);
      print(json.encode(jsonMap));
      var data;
      if (response.body != "")
        data = json.decode(utf8.decode(response.bodyBytes));

      return MyHttpResponse(response.statusCode, data,
          message: response.statusCode != 200 ? '' : '');
    } catch (e) {
      rethrow;
    }
  }

  Future<MyHttpResponse> getRequest(Uri uri,
      {Map<String, String>? additionalHeaders}) async {

    Map<String, String> headers = {
      'Content-Type': "application/json",
    };

    if (additionalHeaders != null) {
      headers = {
        ...headers,
        ...additionalHeaders,
      };
    }

    try {
      var response = await http.get(
        uri,
        headers: headers
      );
      var data;
      print(response.body);
      if (response.body != "") {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
      print(data);
      return MyHttpResponse(response.statusCode, data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MyHttpResponse> getRequestWithToken(Uri uri, String token) async {
    Map<String, String> headers = {
      "'Authorization'": token,
    };
    var response = await http.get(uri, headers: headers);
    var data;
    try {
      if (response.body != "") {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print(e);
    }
    return MyHttpResponse(response.statusCode, data);
  }
}

class MyHttpResponse {
  int statusCode;
  String? message;
  dynamic data;

  MyHttpResponse(this.statusCode, this.data, {this.message});

  @override
  String toString() {
    return 'MyHttpResponse{statusCode: $statusCode, message: $message, data: $data}';
  }
}
