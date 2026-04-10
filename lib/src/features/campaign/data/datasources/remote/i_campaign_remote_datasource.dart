import 'package:investor_app_flutter/src/core/network/response/api_response.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

abstract class ICampaignRemoteDatasource {
  Future<ApiResponse<List<CampaignEntity>>> getCampaigns();
}