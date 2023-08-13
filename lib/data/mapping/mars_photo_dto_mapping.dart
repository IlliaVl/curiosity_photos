import '../../domain/models/mars_photo.dart';
import '../dtos/mars_photo_dto.dart';

/// Extension that provides mappings for [MarsPhotoDTO]
extension MarsPhotoDTOMapping on MarsPhotoDTO {
  /// Maps into a [MarsPhoto]
  MarsPhoto toMarsPhoto() => MarsPhoto(
        id: id,
        photoUrl: imgSrc,
      );
}
