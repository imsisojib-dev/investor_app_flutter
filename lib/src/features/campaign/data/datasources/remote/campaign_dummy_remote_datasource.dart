import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/config/environment/environment.dart' as env;
import 'package:investor_app_flutter/src/core/network/response/api_response.dart';
import 'package:investor_app_flutter/src/features/campaign/data/datasources/remote/i_campaign_remote_datasource.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

import 'fixtures/campaign_fixtures.dart';

@LazySingleton(as: ICampaignRemoteDatasource, env: [env.Environment.mock])
class CampaignDummyRemoteDataSource implements ICampaignRemoteDatasource {
  @override
  Future<ApiResponse<List<CampaignEntity>>> getCampaigns() async {
    return ApiResponse<List<CampaignEntity>>(
      success: true,
      message: 'Successfully fetched campaigns.',
      data: CampaignFixtures.campaigns,
    );
  }
}
