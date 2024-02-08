class ArticleModel {
  final String title;
  final String? description;
  final String articelUrl;
  final String? imageUrl;

  const ArticleModel(
      {required this.title,
      required this.description,
      required this.articelUrl,
      required this.imageUrl});
  factory ArticleModel.fromJson(Map<String, dynamic> jsonData) {
    return ArticleModel(
      title: jsonData['title'],
      description: jsonData['description'],
      articelUrl: jsonData['url'],
      imageUrl: jsonData['urlToImage'],
    );
  }
}
