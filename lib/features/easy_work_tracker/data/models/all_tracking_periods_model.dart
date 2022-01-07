import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';

class AllTrackingPeriodsModel extends AllTrackingPeriods {
  final List<TrackingPeriodModel> trackingPeriodModels;
  const AllTrackingPeriodsModel({required this.trackingPeriodModels})
      : super(trackingPeriods: trackingPeriodModels);

  factory AllTrackingPeriodsModel.fromJson(Map<String, dynamic> jsonMap) {
    List<TrackingPeriodModel> trackingPeriods =
        List<TrackingPeriodModel>.empty(growable: true);
    List<dynamic> decodedList = jsonMap['trackingPeriods'];
    for (int i = 0; i < decodedList.length; i++) {
      trackingPeriods.add(TrackingPeriodModel.fromJson(decodedList[i]));
    }
    return AllTrackingPeriodsModel(trackingPeriodModels: trackingPeriods);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> trackingPeriodsDynamicMapList =
        trackingPeriodModels.map((e) => e.toJson()).toList();

    return {"trackingPeriods": trackingPeriodsDynamicMapList};
  }
}
