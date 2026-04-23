import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/errors/failures.dart';
import 'package:investor_app_flutter/src/features/campaign/data/datasources/remote/i_campaign_remote_datasource.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/repositories/i_campaign_repository.dart';

@LazySingleton(as: ICampaignRepository)
class CampaignRepositoryImpl implements ICampaignRepository {
  final ICampaignRemoteDatasource _remoteDatasource;

  CampaignRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<CampaignEntity>>> getCampaigns() async {
    var response = await _remoteDatasource.getCampaigns();

    if (response.hasData) {
      return Right(response.data!);
    } else {
      return Left(NotFoundFailure(message: 'No campaigns found!'));
    }
  }

  @override
  Future<Either<Failure, CampaignEntity>> getCampaignDetails(String? id) {
    // TODO: implement getCampaignDetails
    throw UnimplementedError();

  }
}
