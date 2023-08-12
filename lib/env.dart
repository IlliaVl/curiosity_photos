import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(
    varName: 'NASA_API_KEY',
    obfuscate: true,
  )
  static String nasaApiKey = _Env.nasaApiKey;
}
