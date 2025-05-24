import '../../data/repositories/album_repository.dart';
import '../entities/album_entity.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  Future<List<AlbumEntity>> execute() async {
    final albums = await repository.fetchAlbums();
    return albums
        .map((album) => AlbumEntity(id: album.id, title: album.title))
        .toList();
  }
}
