import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';

class TrackingPeriodModel extends TrackingPeriod {
  final List<WorkItemModel> trackedWorkItemModels;
  const TrackingPeriodModel(
      {required String title,
      required int usedHourlyRateInEuro,
      required this.trackedWorkItemModels})
      : super(
            title: title,
            usedHourlyRateInEuro: usedHourlyRateInEuro,
            trackedWorkItems: trackedWorkItemModels);

  factory TrackingPeriodModel.fromJson(Map<String, dynamic> jsonMap) {
    List<WorkItemModel> castTrackedWorkItems =
        List<WorkItemModel>.empty(growable: true);
    List<dynamic> decodedList = jsonMap['trackedWorkItems'];
    for (int i = 0; i < decodedList.length; i++) {
      castTrackedWorkItems.add(WorkItemModel.fromJson(decodedList[i]));
    }
    return TrackingPeriodModel(
        title: jsonMap['title'],
        usedHourlyRateInEuro: jsonMap['usedHourlyRateInEuro'],
        trackedWorkItemModels: castTrackedWorkItems);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> trackedWorkItemsDynamicMapList =
        trackedWorkItemModels.map((e) => e.toJson()).toList();

    return {
      'title': title,
      'usedHourlyRateInEuro': usedHourlyRateInEuro,
      'trackedWorkItems': trackedWorkItemsDynamicMapList
    };
  }
}
