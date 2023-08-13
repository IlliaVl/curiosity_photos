import '../../domain/abstracts/repositories/mars_photos_repository_interface.dart';
import '../../domain/models/mars_photo.dart';
import '../mapping/mars_photo_dto_mapping.dart';
import '../providers/nasa_photos_provider.dart';

/// The Firebase repository for authentication.
class NasaRepository extends MarsPhotosRepositoryInterface {
  final NasaPhotosProvider _provider;

  /// Creates new [FirebaseAuthRepository]
  NasaRepository({required NasaPhotosProvider provider}) : _provider = provider;

  @override
  Future<List<MarsPhoto>> getPhotos() async {
    final marsPhotosDto = await _provider.getPhotos();
    return marsPhotosDto.map((dto) => dto.toMarsPhoto()).toList();
  }
}
