import 'package:app_ciudadano/domain/models/news/news_model.dart';
import 'package:equatable/equatable.dart';

class NewsState extends Equatable {
  /// The list of all news.
  final List<NewsModel> newsList;
  /// The list of all news.
  final NewsModel? currentNews;
  final bool initialLoad;
  final bool isLoading;
  final bool finalList;

  const NewsState({
    this.newsList =  const [],
    this.currentNews,
    this.initialLoad = false,
    this.isLoading = false,
    this.finalList = false
  }
  );

  NewsState copyWith({
    List<NewsModel>? newsList,
    NewsModel? currentNews,
    bool? initialLoad,
    bool? isLoading,
    bool? finalList,
  }) =>
      NewsState(
        newsList: newsList ?? this.newsList,
        currentNews: currentNews ?? this.currentNews,
        initialLoad : initialLoad ?? this.initialLoad,
        isLoading: isLoading ?? this.isLoading,
        finalList: finalList ?? this.finalList
      );


  @override
  List<Object?> get props => [
        newsList,
        currentNews,
        initialLoad,
        isLoading,
        finalList
      ];
}
