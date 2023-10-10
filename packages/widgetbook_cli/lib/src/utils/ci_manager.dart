import 'package:ci/ci.dart' as ci;

class CiManager {
  const CiManager();

  ci.Vendor? get vendor => ci.currentVendor;

  bool get isAzure => ci.Vendor.IS_AZURE_PIPELINES;
  bool get isBitbucket => ci.Vendor.IS_BITBUCKET;
  bool get isCodemagic => ci.Vendor.IS_CODEMAGIC;
  bool get isGitHub => ci.Vendor.IS_GITHUB_ACTIONS;
  bool get isGitLab => ci.Vendor.IS_GITLAB;
}
