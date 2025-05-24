import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/album_repository.dart';
import '../../data/models/album.dart';
import '../../data/models/photo.dart';

abstract class AlbumEvent {}
class FetchAlbums extends AlbumEvent {}
class FetchPhotos extends AlbumEvent {
  final int albumId;
  FetchPhotos(this.albumId);
}

abstract class AlbumState {}
class AlbumInitial extends AlbumState {}
class AlbumLoading extends AlbumState {}
class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded(this.albums);
}
class PhotoLoaded extends AlbumState {
  final List<Photo> photos;
  PhotoLoaded(this.photos);
}
class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });

    on<FetchPhotos>((event, emit) async {
      emit(AlbumLoading());
      try {
        final photos = await repository.fetchPhotosByAlbumId(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
