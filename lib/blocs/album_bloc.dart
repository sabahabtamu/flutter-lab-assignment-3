import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/album_repository.dart';
import '../models/album.dart';
import '../models/photo.dart';

// 1. Define the event
abstract class AlbumEvent {}

class FetchAlbums extends AlbumEvent {}

class RetryFetchAlbums extends AlbumEvent {}

// 2. Define the state
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;
  AlbumLoaded(this.albums, this.photos);
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

// 3. Define the bloc
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        final photos = await repository.fetchPhotos();
        emit(AlbumLoaded(albums, photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
    on<RetryFetchAlbums>((event, emit) async {
      add(FetchAlbums());
    });
  }
}
