import 'package:flutter/material.dart';

import '../../domain/models/report/report_model.dart';

class ComplaintsCard extends StatefulWidget {
  final List<String> imagesURL;
  final String createdIn;
  final int id;
  final String address;
  final String description;
  final String responseComplaints;
  final List<ReportModel> complaintsList;
  final int index;
  final ReportModel complaintsModel;

  const ComplaintsCard(
      this.imagesURL,
      this.createdIn,
      this.id,
      this.description,
      this.responseComplaints,
      this.address,
      this.complaintsList,
      this.index,
      this.complaintsModel)
      : super();

  @override
  State<ComplaintsCard> createState() => _ComplaintsCardState();
}

class _ComplaintsCardState extends State<ComplaintsCard> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: imageCarousel(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.id.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      //Use of SizedBox
                      height: 15,
                    ),
                    Text(
                      "Dirección : ${widget.complaintsModel.address}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Descripción : ${widget.complaintsModel.description}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Respuesta denuncia : ${widget.complaintsModel.responseComplaints == "" ? "Sin respuesta" : widget.complaintsModel.responseComplaints}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(
                      //Use of SizedBox
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Fecha de publicación: \n ${(widget.createdIn.split(".")[0])}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageCarousel() {
    return Container(
      child: PageView.builder(
        itemCount: widget.imagesURL.length,
        pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return Image.network(
            widget.imagesURL[pagePosition],
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
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

    for (var i = 0; i < widget.imagesURL.length; i++) {
      Padding dot = _dot(i == selectedPage);
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
}
