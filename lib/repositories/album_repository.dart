import 'dart:convert';
import 'dart:io';
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final HttpClient _httpClient;

  AlbumRepository({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<List<Album>> fetchAlbums() async {
    try {
      final request = await _httpClient.getUrl(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      );
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final List data = json.decode(responseBody);
        return data.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final request = await _httpClient.getUrl(
        Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      );
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final List data = json.decode(responseBody);
        return data.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
