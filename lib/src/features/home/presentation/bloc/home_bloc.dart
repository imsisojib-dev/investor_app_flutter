import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/usecases/usecase_fetch_campaigns.dart';
import 'package:investor_app_flutter/src/features/campaign/presentation/viewmodels/campaign_viewmodel.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_event.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_state.dart';
import 'package:investor_app_flutter/src/shared/models/no_params.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UseCaseFetchCampaigns _getCampaignDetailUseCase;

  HomeBloc(this._getCampaignDetailUseCase) : super(HomeStateCampaigns([])) {
    on<HomeEventInitial>(_fetchInitialCampaigns);
  }

  Future<void> _fetchInitialCampaigns(HomeEventInitial event, Emitter<HomeState> emit) async {
    emit(HomeStateCampaignsFetching());
    await Future.delayed(Duration(seconds: 3));
    var result = await _getCampaignDetailUseCase.execute(NoParams());
    result.fold(
          (error) {
            emit(HomeStateCampaignsError(error.message));
          },
          (data) {
            emit(HomeStateCampaigns(data.map((e)=> CampaignViewmodel(e)).toList()));
          },
    );
  }
}
