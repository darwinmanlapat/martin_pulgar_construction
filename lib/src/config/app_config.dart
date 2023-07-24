import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig._();

  static const instance = AppConfig._();

  static const _values = [
    'REST_ENDPOINT',
  ];

  Future<void> initialize() async {
    await dotenv.load();

    if (!dotenv.isEveryDefined(_values)) {
      throw AssertionError(
        'AppConfig values must be defined in the .env file',
      );
    }
  }

  String get restEndpoint => dotenv.env['REST_ENDPOINT']!;
}
