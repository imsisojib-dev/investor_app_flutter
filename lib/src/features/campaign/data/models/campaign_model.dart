import 'package:investor_app_flutter/src/features/campaign/domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  const CampaignModel({
    required super.id,
    required super.title,
    required super.companyName,
    required super.description,
    required super.imageUrl,
    required super.videoUrl,
    required super.tenure,
    required super.duration,
    required super.profitPercentage,
    required super.returnType,
    required super.returnAmount,
    required super.startingDate,
    required super.closingDate,
    required super.targetAmount,
    required super.acquiredAmount,
    required super.remainingAmount,
    required super.processingAmount,
    required super.status,
    required super.chargesOnInvestmentInPercentage,
    required super.successFeeInPercentage,
    required super.discountInPercentage,
    required super.otherChargeInPercentage,
    required super.minInvestAmount,
    required super.maxInvestAmount,
    required super.riskGrade,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      companyName: json['company_name'],
      description: json['description'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      tenure: json['tenure'],
      duration: json['duration'],
      profitPercentage: json['profit_percentage'],
      returnType: json['return_type'],
      returnAmount: json['return_amount'],
      startingDate: json['starting_date'],
      closingDate: json['closing_date'],
      targetAmount: json['target_amount'],
      acquiredAmount: json['acquired_amount'],
      remainingAmount: json['remaining_amount'],
      processingAmount: json['processing_amount'],
      status: json['status'],
      chargesOnInvestmentInPercentage: json['charge_on_investment_in_percentage'],
      successFeeInPercentage: json['success_fee_in_percentage'],
      discountInPercentage: json['discount_in_percentage'],
      otherChargeInPercentage: json['other_charge_in_percentage'],
      minInvestAmount: json['min_invest_amount'],
      maxInvestAmount: json['max_invest_amount'],
      riskGrade: json['risk_grade']
    );
  }

}
