class NewsModel {
  String? newsID;
  String? typeNewsId;
  String? name;
  DateTime? creationDate;
  DateTime? publishedDate;
  String? description;
  String? userID;
  bool? isPublished;
  List<String>? listImg; 

  NewsModel({
     this.newsID,
    this.typeNewsId,
    this.name,
    this.creationDate,
    this.publishedDate,
    this.description,
    this.userID,
    this.isPublished,
    this.listImg
  }
  );

  

  
}
