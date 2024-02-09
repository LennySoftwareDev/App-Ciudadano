import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';

class ImagesNews extends StatefulWidget {
  final List<String> listaImagenes;
  const ImagesNews({Key? key, this.listaImagenes = const []}) : super(key: key);

  @override
  State<ImagesNews> createState() => _ImagesNewsState();
}

class _ImagesNewsState extends State<ImagesNews> {

  @override
  void initState() {
    super.initState();
    
  }

   int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238, context),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.listaImagenes.isNotEmpty ? widget.listaImagenes.first : "",
              child: cacheNetworkImage(widget.listaImagenes.isNotEmpty ? widget.listaImagenes[selectedImage]: "") , //widget.product.images[selectedImage]
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.listaImagenes.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

   Widget cacheNetworkImage(String image){
    return CachedNetworkImage(
                        
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20 * .2),
          bottom: Radius.circular(20 * .2)),
      shape: BoxShape.rectangle,
      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
    ),
                        ),
                        height: MediaQuery.of(context).size.height > 480
                            ? 100
                            : MediaQuery.of(context).size.height / 7.5,
                        fit: BoxFit.cover,
                        imageUrl: image,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          backgroundColor: Color(0xFFF6993E),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48, context),
        width: getProportionateScreenWidth(48, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.green),
        ),
        child: cacheNetworkImage(widget.listaImagenes[index]),
      ),
    );
  }
}