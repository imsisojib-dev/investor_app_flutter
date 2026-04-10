import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final int id;
  final String title;
  final String companyName;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String tenure;
  final String duration;
  final double profitPercentage;
  final String returnType;
  final String returnAmount;
  final double minInvestAmount;
  final double maxInvestAmount;
  final String startingDate;
  final String closingDate;
  final double targetAmount;
  final double acquiredAmount;
  final double remainingAmount;
  final double processingAmount;
  final String status;
  final double chargesOnInvestmentInPercentage;
  final double successFeeInPercentage;
  final double discountInPercentage;
  final double otherChargeInPercentage;
  final String riskGrade;

  const CampaignEntity({
    required this.id,
    required this.title,
    required this.companyName,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.tenure,
    required this.duration,
    required this.profitPercentage,
    required this.returnType,
    required this.returnAmount,
    required this.startingDate,
    required this.closingDate,
    required this.targetAmount,
    required this.acquiredAmount,
    required this.remainingAmount,
    required this.processingAmount,
    required this.status,
    required this.chargesOnInvestmentInPercentage,
    required this.successFeeInPercentage,
    required this.discountInPercentage,
    required this.otherChargeInPercentage,
    required this.minInvestAmount,
    required this.maxInvestAmount,
    required this.riskGrade,
  });

  @override
  List<Object?> get props => [id];
}
