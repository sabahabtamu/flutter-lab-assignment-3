import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../views/album_list_screen.dart';
import '../views/album_detail_screen.dart';
import '../blocs/album_bloc.dart';
import '../repositories/album_repository.dart';
import '../models/album.dart';
import '../models/photo.dart';

GoRouter createRouter() {
  final albumBloc = AlbumBloc(AlbumRepository());
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => albumBloc,
          child: const AlbumListScreen(),
        ),
      ),
      GoRoute(
        name: 'detail',
        path: '/detail',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          if (data == null) return Container();
          final album = data['album'] as Album;
          final photos = data['photos'] as List<Photo>;
          return AlbumDetailScreen(
            album: album,
            photos: photos,
          );
        },
      ),
    ],
  );
}
