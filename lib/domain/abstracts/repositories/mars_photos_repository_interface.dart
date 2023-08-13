import '../../../domain/models/mars_photo.dart';

/// The abstract repository for Mars photos.
abstract class MarsPhotosRepositoryInterface {
  /// Creates new [MarsPhotosRepositoryInterface]
  MarsPhotosRepositoryInterface();

  /// Gets Mars photos.
  Future<List<MarsPhoto>> getPhotos();
}
