import 'package:app_ciudadano/ui/downloadpdf/ArgumentWebView.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/downloadpdf/downloadpdf_screen.dart';

class Utils {
  /// Returns a flutter color from an hexadecimal string
  static MaterialColor getMaterialColorFromHex(String hexColor) {
    Color color = getColorFromHex(hexColor);

    Map<int, Color> materialColorMap = {
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1),
    };

    MaterialColor materialColor = MaterialColor(
        int.parse("0xFF${hexColor.replaceAll("#", "")}"), materialColorMap);

    return materialColor;
  }

  static Color getColorFromHex(String hexColor) {
    Color color = Colors.yellow;

    String hexColorParsed = hexColor.replaceAll("#", "");

    if (hexColorParsed.length == 6) {
      hexColorParsed = "FF$hexColorParsed";
      color = Color(int.parse("0x$hexColorParsed"));
    }
    if (hexColorParsed.length == 8) {
      color = Color(int.parse("0x$hexColorParsed"));
    }

    return color;
  }

  void visualizePDF(String url, BuildContext context) async {
    if (url.isEmpty) {
      await showDialogFailPdf("Comparendo sin descargable asociado",
          "Comparendo de transito", context);
    } else {
      await Navigator.pushNamed(context, 'viewPDF',
          arguments: ArgumentPDFViewer(url));
    }
  }

  showDialogFailPdf(String mensaje, String titulo, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(titulo, style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(mensaje, textAlign: TextAlign.justify),
      actions: <Widget>[
        ElevatedButton(
            child: const Text("Ok"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, //change background color of button
              onPrimary: Colors.white, //change text color of button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 15.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
