import 'package:equatable/equatable.dart';
import 'package:investor_app_flutter/src/features/campaign/presentation/viewmodels/campaign_viewmodel.dart';

abstract class HomeState extends Equatable {}

class HomeStateCampaignsFetching extends HomeState{
  @override
  List<Object?> get props => [];
}

class HomeStateCampaigns extends HomeState{
  final List<CampaignViewmodel> campaigns;

  HomeStateCampaigns(this.campaigns);

  @override
  List<Object?> get props => [campaigns];
}

class HomeStateCampaignsError extends HomeState{
  final String message;

  HomeStateCampaignsError(this.message);

  @override
  List<Object?> get props => [message];
}
