class SocialMedia {
  int id;
  String jenis;
  String url;
  int articleId;

  SocialMedia({
    required this.id,
    required this.jenis,
    required this.url,
    required this.articleId,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    id: json["id"],
    jenis: json["jenis"],
    url: json["url"],
    articleId: json["article_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jenis": jenis,
    "url": url,
    "article_id": articleId,
  };
}