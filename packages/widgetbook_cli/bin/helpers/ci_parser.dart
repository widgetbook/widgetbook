import 'dart:io';

import 'package:ci/ci.dart' as ci;
import '../models/models.dart';

enum PipelineVendor { isGITHUB, isGITLAB, isAZUREPIPELINES, isBITBUCKET }

abstract class CIParser {
  PipelineData? get getPipelineVendor {
    if (ci.Vendor.IS_GITHUB_ACTIONS) {
      final repository = Platform.environment['GITHUB_REPOSITORY'];

      final actor = Platform.environment['GITHUB_ACTOR'];
      final pipelineData = PipelineData(
        actorName: actor,
        repository: repository,
        pipeline: PipelineVendor.isGITHUB,
      );
      return pipelineData;
    }
    if (ci.Vendor.IS_GITLAB) {
      final repository = Platform.environment['CI_PROJECT_NAME'];

      final actor = Platform.environment['GITLAB_USER_NAME'];
      final pipelineData = PipelineData(
        actorName: actor,
        repository: repository,
        pipeline: PipelineVendor.isGITLAB,
      );
      return pipelineData;
    }
    if (ci.Vendor.IS_AZURE_PIPELINES) {
      final repository = Platform.environment['Build.Repository.Name'];

      final actor = Platform.environment['Agent.Name'];
      final pipelineData = PipelineData(
        actorName: actor,
        repository: repository,
        pipeline: PipelineVendor.isAZUREPIPELINES,
      );
      return pipelineData;
    } else if (ci.Vendor.IS_BITBUCKET) {
      final repository = Platform.environment['BITBUCKET_REPO_FULL_NAME'];

      final pipelineData = PipelineData(
        repository: repository,
        pipeline: PipelineVendor.isBITBUCKET,
      );
      return pipelineData;
    }
    return null;
  }
}
