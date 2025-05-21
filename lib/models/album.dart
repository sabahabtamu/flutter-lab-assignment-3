class Album {
  final int id;
  final String title;
  final int userId;
  Album({required this.id, required this.title, required this.userId});
  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(id: json['id'], title: json['title'], userId: json['userId']);
}
