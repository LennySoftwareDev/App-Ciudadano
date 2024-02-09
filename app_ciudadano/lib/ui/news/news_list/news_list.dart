import 'package:app_ciudadano/di/dependency_injector.dart';
import 'package:app_ciudadano/ui/news/controller/news_bloc.dart';
import 'package:app_ciudadano/ui/news/controller/news_state.dart';
import 'package:app_ciudadano/ui/news/news_list/news_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsList extends StatefulWidget {

  final GlobalKey _mainInfoFormKey = GlobalKey<FormState>();
  NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  ScrollController _controllerNews = ScrollController();
  final NewsBloc _newsBloc = injector.resolve();

  bool loadInfo=false;

  bool onInit =false;

  bool showDialog = false;

  @override
  void initState() {
    super.initState();
    _controllerNews = ScrollController();
    _controllerNews.addListener(_onScrollUpdate); 
    
  }

  @override
  Widget build(BuildContext context) {
    return 
     BlocConsumer<NewsBloc, NewsState>(
      bloc: _newsBloc,
      listener: (context, state) {},
      builder: (context, state) => (){
        if(!state.initialLoad){
          _newsBloc.testNews();
          SchedulerBinding.instance!.addPostFrameCallback(
                  (timeStamp) => {showDialogLoad(context)},
                ); 
          return Container();
        }
        if(state.initialLoad  && showDialog ){
          showDialog = false;
          Navigator.pop(context);
          
          //Navigator.pop(context);
        }
        return _body(state);
        
      }(),
    );
  }

  Widget _body(NewsState state) {
    return  Stack(
            children: [
            
                   Container(
                      height: MediaQuery.of(context).size.height - 10,
                     child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      controller: _controllerNews,
                      itemCount: state.newsList.length,
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 280),
                          child: NewsCard(
                            state.newsList[index].listImg!,
                            state.newsList[index].publishedDate!,
                            state.newsList[index].name!,
                            state.newsList[index].description!,
                            state.newsList,
                            index,
                            state.newsList[index]
                          ),
                        );
                      },
                  ),
                   ),
                
              
              state.finalList ? 
                       const Positioned(
                         bottom: 5,
                         child: Center(child: CircularProgressIndicator())) : Container()
            ],
         
    );
  }

  showDialogLoad(context) {
    showDialog = true;
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) => Container(
              child: Material(
                color: Colors.red.withOpacity(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              ),
            ));
  }

  void _onScrollUpdate(){
    NewsState state = const NewsState();
    print(_controllerNews.offset);
    var maxScroll = _controllerNews.position.maxScrollExtent;
    var currentPosition = _controllerNews.position.pixels;
    if(currentPosition > maxScroll - 10){
      print('llegamos al final');
      loadInfo = true;
      _newsBloc.testNews();

    }
  }
}
