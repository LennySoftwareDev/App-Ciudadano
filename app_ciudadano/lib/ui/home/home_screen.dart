import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/TermsAndConditions/termsAndConditions_screen.dart';
import 'package:app_ciudadano/ui/accidents/accidents_screen.dart';
import 'package:app_ciudadano/ui/citation/publicTransport/publicTransportScreen.dart';
import 'package:app_ciudadano/ui/citation/transit/transit_screen.dart';
import 'package:app_ciudadano/ui/complaints/listReport_screen.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/ui/home/home_state.dart';
import 'package:app_ciudadano/ui/news/news_list/news_list.dart';
import 'package:app_ciudadano/ui/profile/profile_screen.dart';
import 'package:app_ciudadano/ui/report/ireport/ireport_screen.dart';
import 'package:app_ciudadano/ui/sidebar/notification_sidebar/notification_sidebar.dart';
import 'package:app_ciudadano/ui/sidebar/section_sidebar/section_sidebar.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:app_ciudadano/warning_widget.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Create a key

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = injector.resolve();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (context, state) {
        return SafeArea(
            child: WillPopScope(
          onWillPop: () => getalgo(),
          child: Scaffold(
            key: widget._scaffoldKey,
            drawer: SectionSidebar(),
            endDrawer: NotificationSidebar(),
            appBar:
                _appBar(context, state.appSection, state.countNotifications),
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                const WarningWidgetCubit(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.boundariesVertical,
                      horizontal: AppConstants.boundariesHorizontal,
                    ),
                    child: _selectSection(state.appSection),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  Future<bool> getalgo() async {
    return false;
  }

  Widget _selectSection(String appSection) {
    Widget section = Container();

    switch (appSection) {
      case (AppConstants.sectionNews):
        section = NewsList();
        break;
      case (AppConstants.sectionProfile):
        section = ProfileScreen();
        break;
      case (AppConstants.sectionReport):
        section = IReportScreen();
        break;
      case (AppConstants.sectionTicketPublic):
        section = TransitScreen();
        break;
      case (AppConstants.sectionTicketTraffic):
        section = PublicTransportScreen();
        break;
      case (AppConstants.sectionComplain):
        section = ListReportScreen();
        break;
      case (AppConstants.sectionTermsAndConditions):
        section = TermsConditionsScreen();
        break;
      case (AppConstants.sectionAccident):
        section = AccidentsScreen();
        break;
      default:
    }

    return section;
  }

  AppBar _appBar(BuildContext context, String title, int countNotificacions) =>
      AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => widget._scaffoldKey.currentState!
              .openDrawer(), // <-- Opens drawer
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: badge.Badge(
              position: badge.BadgePosition.topEnd(),
              elevation: 10,
              badgeContent: Text(countNotificacions.toString()),
              child: IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () => widget._scaffoldKey.currentState!
                    .openEndDrawer(), // <-- Opens drawer
              ),
            ),
          )
        ],
      );
}
