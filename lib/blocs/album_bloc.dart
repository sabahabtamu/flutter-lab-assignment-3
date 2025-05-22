import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

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
