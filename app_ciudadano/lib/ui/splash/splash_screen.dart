import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/ui/home/home_state.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:app_ciudadano/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  final HomeBloc _homeBloc = injector.resolve();
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (previous, current) {
          return previous.isLoading != current.isLoading;
        },
        listener: (context, state) {
          Navigator.of(context).pop();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Utils.getColorFromHex(AppConstants.primaryColor),
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .40,
                  maxWidth: MediaQuery.of(context).size.width * .90,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _citySecretaryLogo(),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: _appTitle(context),
                        ),
                      ],
                    ),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Center _appTitle(BuildContext context) => const Center(
        child: Text(
          "App Ciudadanos",
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      );

  Row _citySecretaryLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 0,
            ),
            child: SizedBox(
              height: 70,
              width: 70,
              child: Image(
                image: AssetImage('assets/images/neiva_coat_of_arms.png'),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Secretaría de transito y transporte municipal".toUpperCase(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
}
