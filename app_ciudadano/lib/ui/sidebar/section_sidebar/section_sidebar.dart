import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/home/home_bloc.dart';
import 'package:app_ciudadano/utils/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionSidebar extends StatelessWidget {
  final HomeBloc _homeBloc = injector.resolve();
  final Map<String, IconData> _profileSectionToIcons = {
    AppConstants.sectionProfile: Icons.person,
    AppConstants.sectionReport: Icons.report,
    AppConstants.sectionComplain: Icons.important_devices,
  };

  final Map<String, IconData> _consultSectionToIcons = {
    AppConstants.sectionAccident: Icons.commute_outlined,
    AppConstants.sectionTicket: Icons.search,
    AppConstants.sectionNormative: Icons.book,
    AppConstants.sectionNews: Icons.newspaper,
  };

  final Map<String, IconData> _extrasSectionToIcons = {
    AppConstants.sectionTermsAndConditions: Icons.balance,
    AppConstants.sectionExit: Icons.logout,
  };

 

  SectionSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppConstants.boundariesVertical,
            bottom: AppConstants.boundariesVertical,
            left: 25.0,
            right: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getSectionList(
                  context, _profileSectionToIcons, "Perfil".toUpperCase()),
              _getSectionList(
                  context, _consultSectionToIcons, "Consultas".toUpperCase()),
              _getSectionList(context, _extrasSectionToIcons, ""),
            ],
          ),
        ),
      ),
    );
  }

  Column _getSectionList(
    BuildContext context,
    Map<String, IconData> info,
    String title,
  ) {
    List<Widget> sectionList = [];

    info.forEach((key, value) {
      String title = key;
      IconData icon = value;
      Widget section;
      if(title == AppConstants.sectionTicket){
        section = sectionWhitSubMenu(title, icon, context);
      }
      else{
       section = _section(title, icon, context, 10);
      }
      

      sectionList.add(section);
    });

    Column section = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        title != ""
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
        ...sectionList,
      ],
    );

    return section;
  }

  GestureDetector _section(String title, IconData icon, BuildContext context, double rightPading) {
    String url = 'https://www.alcaldianeiva.gov.co/Gestion/Paginas/Normatividad.aspx';
    return GestureDetector(
      onTap: () async{
        if(title == AppConstants.sectionNormative){
          if (!await launch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }else{
          _homeBloc.setCurrentSection(title);
          Navigator.of(context).pop();  
        }
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.0, left: rightPading),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Flexible(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionWhitSubMenu(String title, IconData icon, BuildContext context, ){
    return ExpandablePanel(
      theme: ExpandableThemeData(iconColor: Theme.of(context).colorScheme.primary, iconPadding: const EdgeInsets.only(bottom: 2) ) ,
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 10),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Flexible(
              child: Text(title),
            ),
          ],
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Column(children: [
         _section(AppConstants.sectionSearchTicketTransit, Icons.car_repair_outlined, context, 45),
         _section(AppConstants.sectionSearchTicketPublicTransport, Icons.airport_shuttle_outlined, context,45)
      ],),
      
    );
  }
}
