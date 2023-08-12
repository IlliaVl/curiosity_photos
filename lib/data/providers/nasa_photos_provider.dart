import 'package:dio/dio.dart';

import '../abstracts/network/net_client.dart';

/// Photos data provider
class NASAPhotosProvider {
  static const _photosEndpoint = '/rovers/curiosity/photos';

  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates new [NASAPhotosProvider]
  NASAPhotosProvider(this.netClient);

  /// Returns list of photos.
  Future<Response<dynamic>> getPhotos(
    String apiKey,
  ) async {
    final response = await netClient(
      _photosEndpoint,
      queryParameters: {
        'sol': '1000',
        'api_key': apiKey,
      },
    );
    if (response.data is Map<String, dynamic>) {
      final photos = response.data['photos'];
      if (photos is List) {
        print('Photos is List');
      }
      return response;
    }
    throw 'Photos were not received';
  }
}
