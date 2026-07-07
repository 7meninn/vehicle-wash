import '../../domain/entities/earning.dart';

class EarningModel extends Earning {
  EarningModel({
    required super.completedJobs,
    required super.estimatedPayout,
  });

  factory EarningModel.fromJson(Map<String, dynamic> json) {
    return EarningModel(
      completedJobs: json['completedJobs'] as int,
      estimatedPayout: (json['estimatedPayout'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedJobs': completedJobs,
      'estimatedPayout': estimatedPayout,
    };
  }
}
