import 'package:app_ciudadano/domain/models/news/news_model.dart';
import 'package:app_ciudadano/ui/news/news_list/detail_new/app_bar_detail_nes.dart';
import 'package:app_ciudadano/ui/news/news_list/detail_new/images_new.dart';
import 'package:app_ciudadano/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailNewScreen extends StatefulWidget {
  final NewsModel newsModel;
  const DetailNewScreen(this.newsModel) : super();

  @override
  State<DetailNewScreen> createState() => _DetailNewScreenState();
}

class _DetailNewScreenState extends State<DetailNewScreen> {
  @override  
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const AppBarDetailNews(),
      ),
     
      body: ListView(
        
      children: [
        
       
        
        const SizedBox(height: 10),
        ImagesNews(listaImagenes:widget.newsModel.listImg!),
        infomacionNoticia(context)
      ],
    )
      
      
    );
  }

  Widget infomacionNoticia(BuildContext context){
    return  TopRoundedContainer(
            
             Colors.white,
             Column(
              children: [
                detailNews(),
                TopRoundedContainer(
                  const Color(0xFFF6F7F9),
                  Column(
                    children: const [
                      /*ColorDots(
                        product: this.widget.product,
                        cantidad: this.cantidad,
                        modificarCantidadProducto:
                            this.modificarCantidadProducto,
                        esProductoSinExistencia: this.esProductoSinExistencia,
                      ),*/
                     
                    ],
                  ),
                  context
                ),
              ],
            ),
            context
          );
       
  }

  Widget TopRoundedContainer(Color color,Widget child, BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20, context)),
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20, context)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }

  Widget detailNews(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20, context)),
          child: Text(
            widget.newsModel.name!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15, context)),
            width: getProportionateScreenWidth(64, context),
            decoration: const BoxDecoration(
              color:
                  Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/images/Heart Icon_2.svg",
              color:
                   const Color(0xFFFF4848) ,
              height: getProportionateScreenWidth(16, context),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20, context),
            right: getProportionateScreenWidth(20, context),
          ),
          child: Text(
            widget.newsModel.description!,
            maxLines: 70,
            textAlign: TextAlign.justify,
            
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20, context),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  DateFormat.yMd().add_jm().format(widget.newsModel.publishedDate!),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.green),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}