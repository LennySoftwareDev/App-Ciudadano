import 'package:app_ciudadano/data/database/repository/user_repository.dart';
import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/domain/models/user/preferenceDb/user_preferences.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:flutter/material.dart';

class WalkThroughScreen extends StatefulWidget {
  final PageController _pageController = PageController();

  WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  /// List of steps.
  ///
  /// The map key is the. The list contains the asset path and the
  /// description of the step.
  final Map<String, List<String>> _stepToStepInfo = {
    "Novedades": [
      "assets/images/novedades.png",
      "Recibe las últimas novedades sobre la movilidad en Neiva. Cierres viales, decretos y mas ",
    ],
    "Comparendos": [
      "assets/images/comparendo.png",
      "Obten tu lista de comparendos. Estos seran catalogados como comparendos de transporte publico y de transito.",
    ],
    "Denuncias": [
      "assets/images/denuncia.png",
      "Realiza denuncias sobre el tráfico y compartelos a través de la app. Nuestro equipo analizara la situación y desplegara personal si es necesario",
    ],
    "Accidentes": [
      "assets/images/accidente.png",
      "Revisa y accede a los detalles de los accidentes donde tuviste alguna participación",
    ],
  };

  /// Indicates the total of steps.
  int _numberOfSteps = 0;

  /// Indicates current index in the list of steps.
  int _currentStepIndex = 0;
    final UserRepositoryDB _userRepositoryDB = injector.resolve();

  @override
  void initState() {
    _getNumberOfSteps();
    super.initState();
  }

  @override
  void dispose() {
    widget._pageController.dispose();
    super.dispose();
  }

  void _getNumberOfSteps() => _numberOfSteps = _stepToStepInfo.keys.length;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.boundariesVertical,
            horizontal: AppConstants.boundariesHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 9,
                child: _pageView(),
              ),
              Expanded(
                flex: 1,
                child: _stepsIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _stepsIndicator() => Row(
        children: [
          TextButton(
            onPressed: () {
              UserPreferences userPreferences = UserPreferences(true);
              _userRepositoryDB.addUserPreferencesToDB(userPreferences);
              Navigator.pushReplacementNamed(context,"home");
            },
            child: Text(
              "Saltar".toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: _dotIndicators(),
          ),
          TextButton(
            onPressed: _nextStep,
            child: Text(
              "Siguiente".toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
        ],
      );

  void _nextStep() {
    if (_currentStepIndex < _numberOfSteps - 1) {
      widget._pageController.animateToPage(
        _currentStepIndex + 1,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 300),
      ); 
      setState(() {
        _currentStepIndex++;
      });
    } else {
      UserPreferences userPreferences = UserPreferences(true);
      _userRepositoryDB.addUserPreferencesToDB(userPreferences);
      Navigator.pushReplacementNamed(context,"home");
    }
  }

  Row _dotIndicators() {
    Row dotRow = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _getDots(),
    );

    return dotRow;
  }

  List<Widget> _getDots() {
    List<Widget> dotIndicators = [];

    for (var i = 0; i < _numberOfSteps; i++) {
      Padding dot = _dot(i == _currentStepIndex);
      dotIndicators.add(dot);
    }

    return dotIndicators;
  }

  Padding _dot(bool isSelectedDot) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectedDot
                ? Theme.of(context).hintColor
                : Theme.of(context).focusColor,
          ),
        ),
      );

  PageView _pageView() => PageView(
        onPageChanged: (int pageIndex) {
          setState(() {
            _currentStepIndex = pageIndex;
          });
        },
        controller: widget._pageController,
        children: _getSteps(),
      );

  List<Widget> _getSteps() {
    List<Widget> stepPageList = [];

    _stepToStepInfo.forEach((key, value) {
      String title = key;
      String assetName = value[0];
      String description = value[1];

      Column stepPage = _stepPage(title, assetName, description);

      stepPageList.add(stepPage);
    });

    return stepPageList;
  }

  Column _stepPage(
    String title,
    String assetName,
    String description,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          
          
             SizedBox(
               height: 400,
              child: Image(
                
                fit: BoxFit.fill,
                image: AssetImage(assetName),
              ),
            ),
         
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );
}
