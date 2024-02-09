import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/domain/models/user/user_credentials_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();
  final GlobalKey _mainAddressFormKey = GlobalKey<FormState>();
  final GlobalKey _mainContactFormKey = GlobalKey<FormState>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _controllerDocumento = TextEditingController();
  final TextEditingController _controllerNombres = TextEditingController();
  final TextEditingController _controllerApellidos = TextEditingController();
  final TextEditingController _controllerCelular = TextEditingController();
  final TextEditingController _controllerCorreoElectronico = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();
  UserCrendentials userCrendentials = injector.resolve();


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _userMainInfoCard(),
        
        _userContactCard(),
      ],
    );
  }

  Widget _userMainInfoCard() {
    _controllerDocumento.text = userCrendentials.persona!.numerodocumento;
    _controllerNombres.text = userCrendentials.persona!.primerNombre + 
    ' ' + (userCrendentials.persona!.segundoNombre != null ? userCrendentials.persona!.segundoNombre! : "") ;
    _controllerApellidos.text = userCrendentials.persona!.apellidoPaterno + 
    ' ' + (userCrendentials.persona!.apellidoMaterno != null ? userCrendentials.persona!.apellidoMaterno! : "") ;
    _controllerCelular.text = userCrendentials.persona!.telefonoCelular != null ? userCrendentials.persona!.telefonoCelular! : "";
    _controllerCorreoElectronico.text = userCrendentials.persona!.correoElectronico != null ? userCrendentials.persona!.correoElectronico! : "";
    _controllerUsuario.text = userCrendentials.usuario != null ? userCrendentials.usuario! : "";
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
          ),
          child: Text(
            "Información Personal".toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Form(
              key: widget._mainInfoFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  _textFormField("Identificacion", _controllerDocumento),
                  _textFormField("Nombres", _controllerNombres),
                  _textFormField("Apellidos", _controllerApellidos),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                       Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFormField(
    String label,
    TextEditingController _controller
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            top: 30,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        TextFormField(
          enabled: false,
          controller: _controller,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            
          ),
        ),
      ],
    );
  }

  Widget _userContactCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
          ),
          child: Text(
            "Contacto".toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Form(
              key: widget._mainContactFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _textFormField("Correo", _controllerCorreoElectronico),
                  _textFormField("Celular", _controllerCelular),
                  _textFormField("Usuario", _controllerUsuario),
                  
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
