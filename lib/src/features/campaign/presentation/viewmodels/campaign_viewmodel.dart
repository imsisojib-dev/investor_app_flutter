import 'package:equatable/equatable.dart';
import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

class CampaignViewmodel extends Equatable{
  final CampaignEntity _entity;
  const CampaignViewmodel(this._entity);

  //UI pass-through identity
  String get title => _entity.title;
  String get companyName => _entity.companyName;
  String get description => _entity.description;
  String get imageUrl => _entity.imageUrl;
  String get videoUrl => _entity.videoUrl;
  String get tenure => _entity.tenure;
  String get duration => _entity.duration;
  double get profitPercentage => _entity.profitPercentage;
  String get returnType => _entity.returnType;
  String get returnAmount => _entity.returnAmount;
  String get startingDate => _entity.startingDate;
  String get closingDate => _entity.closingDate;
  double get targetAmount => _entity.targetAmount;
  double get acquiredAmount => _entity.acquiredAmount;
  double get remainingAmount => _entity.remainingAmount;
  double get processingAmount => _entity.processingAmount;
  String get status => _entity.status;
  double get chargesOnInvestmentInPercentage => _entity.chargesOnInvestmentInPercentage;
  double get successFeeInPercentage => _entity.successFeeInPercentage;
  double get discountInPercentage => _entity.discountInPercentage;
  double get otherChargeInPercentage => _entity.otherChargeInPercentage;
  double get minInvestAmount => _entity.minInvestAmount;
  double get maxInvestAmount => _entity.maxInvestAmount;


  @override
  List<Object?> get props => [_entity.id];


}