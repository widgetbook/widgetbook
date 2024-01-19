abstract class Environment {
  Environment({
    required this.name,
    required this.appUrl,
    required this.apiUrl,
  });

  final String name;
  final String appUrl;
  final String apiUrl;
}

class ProductionEnv extends Environment {
  ProductionEnv()
      : super(
          name: 'production',
          appUrl: 'https://app.widgetbook.io/',
          apiUrl: 'https://api.widgetbook.io/',
        );
}

class StagingEnv extends Environment {
  StagingEnv()
      : super(
          name: 'staging',
          appUrl: 'https://staging.app.widgetbook.io/',
          apiUrl: 'https://staging.api.widgetbook.io/',
        );
}

class DebugEnv extends Environment {
  DebugEnv()
      : super(
          name: 'debug',
          appUrl: 'https://staging.app.widgetbook.io/',
          apiUrl: 'http://localhost:3000/',
        );
}
