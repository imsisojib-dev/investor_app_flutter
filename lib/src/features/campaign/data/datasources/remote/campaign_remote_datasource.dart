import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/network/api_client.dart';
import 'package:investor_app_flutter/src/core/network/response/api_response.dart';
import 'package:investor_app_flutter/src/features/campaign/data/datasources/remote/i_campaign_remote_datasource.dart';
import 'package:investor_app_flutter/src/config/environment/environment.dart' as env;
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

@LazySingleton(as: ICampaignRemoteDatasource, env: [env.Environment.prod, env.Environment.dev])
class CampaignRemoteDatasource implements ICampaignRemoteDatasource {
  final IApiClient _apiClient;

  CampaignRemoteDatasource(this._apiClient);

  @override
  Future<ApiResponse<List<CampaignEntity>>> getCampaigns() {
    throw UnimplementedError();
  }
}
