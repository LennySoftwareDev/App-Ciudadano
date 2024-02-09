
import 'package:app_ciudadano/ui/citation/transit/transit_state.dart';
import 'package:flutter/material.dart';

class SearchCitations extends StatelessWidget {
  final TransitState _transitState = TransitState();
  final Color organizationColor;
  final String title;
  final String parentTitle;
  final Function searchQuery;
  final Widget results;
  final bool allColor;
  final Color alternativeColor;
  final String hintText;
  final bool backButton;
  final bool bottomBar;
  final bool favoritesLabel;
  final Color backgroundColor;
  final bool enabled;
  TextEditingController controller;

  SearchCitations({
    required this.organizationColor,
    required this.title,
    required this.parentTitle,
    required this.searchQuery,
    required this.results,
    required this.hintText,
    this.backButton = true,
    this.allColor = false,
    this.bottomBar = true,
    this.favoritesLabel = false,
    required this.alternativeColor,
    required this.backgroundColor,
    this.enabled = true,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller = TextEditingController();
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 120,
        width: MediaQuery.of(context).size.width - 40,
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          drawer: const SizedBox(),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(children: <Widget>[
              
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5,),
                      child: Text(
                        parentTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    searchField(context, constraints),
                    results,
                  ],
                ),
              
            ]),
          )
        ),
      );
    });
  }

  Widget searchField(BuildContext context, BoxConstraints constraints) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        TextField(
          style: const TextStyle(color: Colors.red),
          keyboardType: TextInputType.text,
          onChanged: (value) => searchQuery(value),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 20.0),
            enabled: enabled,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 18.0, color: Colors.grey),
            suffixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
