import '../abstracts/network/net_client.dart';

/// Net client for NASA API
class NasaClient extends NetClient {
  static const String _baseUrl = 'https://api.nasa.gov/mars-photos/api/v1';

  /// Creates new [NasaClient]
  NasaClient()
      : super(
          baseUrl: _baseUrl,
        );
}
