class MovieModels {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  MovieModels({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  // convert json to movie model

  factory MovieModels.fromJson(Map<String, dynamic> json) {
    return MovieModels(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }

  //convert movie model to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
    };
  }
}
