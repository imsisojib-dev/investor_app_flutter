import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/errors/failures.dart';
import 'package:investor_app_flutter/src/core/interfaces/interface_use_case.dart';
import 'package:investor_app_flutter/src/shared/models/no_params.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/repositories/i_campaign_repository.dart';

@LazySingleton(as: IUseCase)
class UseCaseFetchCampaigns implements IUseCase<NoParams, List<CampaignEntity>>{
  final ICampaignRepository _repository;

  UseCaseFetchCampaigns(this._repository);

  @override
  Future<Either<Failure, List<CampaignEntity>>> execute(_) {
    return _repository.getCampaigns();
  }
}