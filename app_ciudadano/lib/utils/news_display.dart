import 'package:flutter/material.dart';

class NewsDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> testImagesURL = [
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-24-at-6.14.55-PM-1024x768.jpeg",
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-23-at-8.22.40-PM-1-1024x683.jpeg",
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-24-at-5.21.03-PM-1024x768.jpeg",
  ];
  const String image = "https://arbolabc.nyc3.cdn.digitaloceanspaces.com/Science/animals/articles/animales-domesticos/dog.jpg";
    return Stack(
      children: <Widget>[
       
        Align(
          
          alignment: const Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: SizedBox(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 18.0,
                    ),
                    child: Container(
                      child: Hero(
                        tag:'assets/images/niños.jpg',
                        child: Image.asset(
                          'assets/images/niños.jpg',
                          fit: BoxFit.contain,
                          height: 400,
                          width: 400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 100.0,
          child: RawMaterialButton(
            onPressed: () => {},
            constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
            child:
                const Icon(Icons.favorite, color: Color.fromRGBO(255, 137, 147, 1)),
            elevation: 0.0,
            shape: const CircleBorder(),
            fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
          ),
        )
      ],
    );
  }
}