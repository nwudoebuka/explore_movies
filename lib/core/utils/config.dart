
import 'package:explore/service_locator.dart' as service_locator;

enum Environment { dev, prod }

class AppConfig {
  AppConfig._();

  static Environment environment = Environment.dev;

  // init dependencies needed during the runApp process
  static Future<void> initDependencies({
    Environment environment = Environment.dev,
  }) async {
    AppConfig.environment = environment;
    AppConfig.setEnvironment(environment);
    await service_locator.setUpLocator();
  }

  // constants values to be given based on the environment set
  static late Map<String, String> _constants;

  // set the environment to run the app in
  static void setEnvironment(Environment environment) {
    AppConfig.environment = environment;
    switch (environment) {
      case Environment.dev:
        _constants = _Constants.devConstants;
        break;

      case Environment.prod:
        _constants = _Constants.prodConstants;
        break;
    }
  }

  // base url based on the environment set
  static String get baseUrl {
    return _constants[_Constants.baseUrl]!;
  }

  static String get apiKey {
    return _constants[_Constants.apiKey]!;
  }
}

class _Constants {
  static const baseUrl = 'BASE_URL';
  static const apiKey = 'API_KEY';

  static Map<String, String> devConstants = {
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '81d07e9cc40a8276a21a2fda931bebef&language',
  };

  static Map<String, String> prodConstants = {
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '81d07e9cc40a8276a21a2fda931bebef&language',
  };
}
