// class ViewModel {
//  late String image,title,subTilte;
//  late double rate;
//
//   ViewModel({ required this.image, required this.title, required this.subTilte, required this.rate});
//     ViewModel.fromMap(Map<String,dynamic>map)
//     {
//       image = "https://image.tmdb.org/t/p/original${map["backdrop_path"]}";
//       title = map["original_title"];
//       subTilte= map["overview"];
//       rate = map["vote_average"];
//     }
// }


class MoviesData {
  MoviesData({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  late final int page;
  late final List<ViewModel> results;
  late final int totalPages;
  late final int totalResults;

  MoviesData.fromJson(Map<String, dynamic> json){
    page = json['page'];
    results = List.from(json['results']).map((e)=>ViewModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class ViewModel {

  late final bool adult;
  late final String image;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  ViewModel.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    image = json["backdrop_path"]== null?"https://t3.ftcdn.net/jpg/02/50/11/74/360_F_250117480_cj8OmvlMdaoUakIMzQgEOSgs5dNW0CFT.jpg":"https://image.tmdb.org/t/p/original${json["backdrop_path"]}";
    //json['backdrop_path'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = double.parse((json['vote_average']??0).toString()) ;
    voteCount = json['vote_count'];
  }

}