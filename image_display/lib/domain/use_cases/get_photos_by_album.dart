import '../../data/repositories/album_repository.dart';
import '../entities/photo_entity.dart';

class GetPhotosByAlbum {
  final AlbumRepository repository;

  GetPhotosByAlbum(this.repository);

  Future<List<PhotoEntity>> execute(int albumId) async {
    final photos = await repository.fetchPhotosByAlbumId(albumId);
    return photos
        .map(
          (photo) => PhotoEntity(
            albumId: photo.albumId,
            id: photo.id,
            title: photo.title,
            url: photo.url,
            thumbnailUrl: photo.thumbnailUrl,
          ),
        )
        .toList();
  }
}
