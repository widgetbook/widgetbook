enum DeploymentStrategy { production, staging, debug }

class Flavor {
  factory Flavor() {
    return _singleton;
  }

  Flavor._internal();

  DeploymentStrategy strategy = DeploymentStrategy.staging;
  bool get isStaging => strategy == DeploymentStrategy.staging;
  bool get isProduction => strategy == DeploymentStrategy.production;
  bool get isDebug => strategy == DeploymentStrategy.debug;

  static final Flavor _singleton = Flavor._internal();
}
