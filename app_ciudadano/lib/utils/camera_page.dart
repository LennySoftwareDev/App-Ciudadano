import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late XFile? _image;
  var picker = ImagePicker();
  var message = "";

  Future getImageCamera() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    }
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70
    );

    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    }
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
 
    return  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: _image == null
                      ? Container()
                      : Image.file(File(_image!.path))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _image == null
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  elevation: MaterialStateProperty.all(5),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                onPressed: getImageCamera,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.camera_enhance,
                                        size: 40,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "CAMARA",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              16,
                                          fontFamily: 'Hind',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  elevation: MaterialStateProperty.all(5),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                onPressed: getImageGallery,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.insert_photo,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "GALERIA",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              16,
                                          fontFamily: 'Hind',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.08,
                            /*child: LoadingButton(
                              color: Colors.red,
                              borderRadius: 10,
                              defaultWidget: Text(
                                'TRADUCIR',
                                style: TextStyle(
                                  color:  Colors.amber,
                                  fontSize:
                                  MediaQuery.of(context).textScaleFactor *
                                      20,
                                  fontFamily: 'Hind',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              /*onPressed: () async {
                                //message = await userProvider.GetTraduction(_image!);
                                switch (message){
                                  case "NOT_FOUND":
                                    ModalInfo(context, "No hemos encontrado esta seña, por favor ingresa otra seña.");
                                    break;
                                  case "ERROR":
                                    ModalError(context);
                                    break;
                                  case "TRY_AGAIN":
                                    ModalInfo(context, "No se ha encontrado una mano en la imagen, por favor intentalo de nuevo.");
                                    break;
                                  default:
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (BuildContext context) => new ResponseImage(image: _image, word: message))
                                    );
                                    break;
                                }
                              },*/
                            ),*/
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                _image = null;
                              })
                            },
                            child: Text(
                              'CAMBIAR IMAGEN',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 18,
                                fontFamily: 'Hind',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          GestureDetector(
                            onTap: () => {
                              //ModalCancel(context)
                            },
                            child: Text(
                              'CANCELAR TRADUCCIÓN',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 18,
                                fontFamily: 'Hind',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        );
  }
}