class WebToonModel {
  final String id, title, thumb;

  WebToonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  WebToonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
