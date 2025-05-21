import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
