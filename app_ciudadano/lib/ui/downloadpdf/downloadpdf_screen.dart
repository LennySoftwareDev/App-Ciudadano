import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toast/toast.dart';

import 'ArgumentWebView.dart';

class WebViewPage extends StatefulWidget {
  @override
  State<WebViewPage> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewPage> {
  ArgumentPDFViewer? argumentWebView;
  bool stateButton = false;

  Future<bool> saveFileTrafficTicketPDF() async {
    final storageIO = InternetFileStorageIO();

    if (argumentWebView?.url != null) {
      await InternetFile.get(
        argumentWebView!.url,
        storage: storageIO,
        storageAdditional: storageIO.additional(
          filename: 'comparendo.pdf',
          location: '/storage/emulated/0/Download',
        ),
        force: true,
        progress: (receivedLength, contentLength) {
          final percentage = receivedLength / contentLength * 100;
          print(
              'download progress: $receivedLength of $contentLength ($percentage%)');
        },
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    argumentWebView =
        ModalRoute.of(context)?.settings.arguments as ArgumentPDFViewer?;

    if (argumentWebView?.url == null) {
      showToast(
          "Error al descargar el archivo. Verifique su "
          "conexión a internet e intente nuevamente.",
          gravity: Toast.bottom,
          duration: Toast.lengthLong);
      return Scaffold(
          appBar: AppBar(
        title: const Text("Error al visualizar pdf"),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Descarga tu comparendo"),
        ),
        body: SfPdfViewer.network(
          argumentWebView!.url,
          onDocumentLoadFailed: (details) {
            showToast(
                "${details.error}: Verifique su conexión a internet e intente nuevamente",
                duration: Toast.lengthLong);
          },
          onDocumentLoaded: (details) {
            setState(() {
              stateButton = true;
            });
          },
        ),
        floatingActionButton: ElevatedButton.icon(
            onPressed: stateButton != true
                ? null
                : () async {
              await saveFileTrafficTicketPDF()
                  ? showToast("Archivo descargado correctamente",
                  gravity: Toast.bottom, duration: Toast.lengthLong)
                  : showToast(
                  "Error al descargar el archivo. Verifique su "
                      "conexión a internet e intente nuevamente.",
                  gravity: Toast.bottom,
                  duration: Toast.lengthLong);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.download),
            label: const Text('descargar')),
      );
    }
  }
}
