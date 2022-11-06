import 'package:ci/ci.dart' as ci;

class CiWrapper {
  bool isCI() {
    return ci.isCI;
  }

  bool isGithub() {
    return ci.Vendor.IS_GITHUB_ACTIONS;
  }

  bool isGitLab() {
    return ci.Vendor.IS_GITLAB;
  }

  bool isAzure() {
    return ci.Vendor.IS_AZURE_PIPELINES;
  }

  bool isBitBucket() {
    return ci.Vendor.IS_BITBUCKET;
  }
}
