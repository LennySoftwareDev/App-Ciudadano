import 'package:app_ciudadano/domain/models/news/news_model.dart';
import 'package:app_ciudadano/domain/repository/general_repository.dart';
import 'package:app_ciudadano/ui/news/controller/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 final List<String> testImagesURL = [
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-24-at-6.14.55-PM-1024x768.jpeg",
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-23-at-8.22.40-PM-1-1024x683.jpeg",
    "https://noticiasalcaldianeiva.gov.co/wp-content/uploads/2022/03/WhatsApp-Image-2022-03-24-at-5.21.03-PM-1024x768.jpeg",
  ];

class NewsBloc extends Cubit<NewsState> {
  final GeneralRepository _generalRepository;
   List<NewsModel> allNews = [];
  int pagina = 0;
  int loadNews = 0;
  NewsBloc(this._generalRepository) : super(const NewsState());


  void testNews() async{
    emit(state.copyWith(
      finalList: true
    ));
    loadNews = loadNews + 1 ;
    pagina = pagina + 1 ;
    List<NewsModel> news = await _generalRepository.getNews(pagina,10);
    allNews.addAll(news);
    
    emit(state.copyWith(
      initialLoad: true,
      newsList: allNews,
      finalList: !state.finalList
    ));
  }

  List<NewsModel> addImageFake(List<NewsModel> list){
    for (var element in list) {
      element.listImg = testImagesURL;
    }
    return list;
  }

}
