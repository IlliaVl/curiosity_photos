import '../../domain/exceptions/curiosity_exception.dart';
import '../abstracts/network/net_client.dart';
import '../dtos/mars_photo_dto.dart';

/// Photos data provider.
class NasaPhotosProvider {
  static const _photosEndpoint = '/rovers/curiosity/photos';

  /// The NetClient to use for the network requests.
  final NetClient netClient;

  /// Key for API calls.
  final String apiKey;

  /// Creates new [NasaPhotosProvider]
  NasaPhotosProvider({
    required this.netClient,
    required this.apiKey,
  });

  /// Returns list of photos.
  Future<List<MarsPhotoDTO>> getPhotos() async {
    final response = await netClient(
      _photosEndpoint,
      queryParameters: {
        'sol': '1000',
        'api_key': apiKey,
      },
    );
    if (response.statusCode != 200) {
      throw const CuriosityException(
        CuriosityExceptionType.api,
      );
    }
    try {
      if (response.data is Map<String, dynamic>) {
        final marsPhotosDto = MarsPhotoDTO.fromJsonList(
          List<Map<String, dynamic>>.from(response.data['photos']),
        );
        return marsPhotosDto;
      }
    } on Exception catch (_) {
      throw const CuriosityException(
        CuriosityExceptionType.parsing,
      );
    }
    return [];
  }
}
