import 'package:dartz/dartz.dart';
import 'package:investor_app_flutter/src/core/errors/failures.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

abstract class ICampaignRepository {
  Future<Either<Failure, List<CampaignEntity>>> getCampaigns();
}