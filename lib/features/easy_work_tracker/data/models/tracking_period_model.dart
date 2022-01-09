import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';

class TrackingPeriodModel extends TrackingPeriod {
  final List<WorkItemModel> trackedWorkItemModels;
  const TrackingPeriodModel(
      {required int id,
      required String title,
      required int usedHourlyRateInEuro,
      required this.trackedWorkItemModels})
      : super(
            id: id,
            title: title,
            usedHourlyRateInEuro: usedHourlyRateInEuro,
            trackedWorkItems: trackedWorkItemModels);

  factory TrackingPeriodModel.fromJson(Map<String, dynamic> jsonMap) {
    List<WorkItemModel> castTrackedWorkItems = List<WorkItemModel>.empty(growable: true);
    List<dynamic> decodedList = jsonMap['trackedWorkItems'];
    for (int i = 0; i < decodedList.length; i++) {
      castTrackedWorkItems.add(WorkItemModel.fromJson(decodedList[i]));
    }
    return TrackingPeriodModel(
        id: jsonMap['id'],
        title: jsonMap['title'],
        usedHourlyRateInEuro: jsonMap['usedHourlyRateInEuro'],
        trackedWorkItemModels: castTrackedWorkItems);
  }

  factory TrackingPeriodModel.fromTrackingPeriod(TrackingPeriod entity) {
    List<WorkItemModel> entityWorkItemsConverted = List<WorkItemModel>.empty(growable: true);
    for (int i = 0; i < entity.trackedWorkItems.length; i++) {
      entityWorkItemsConverted.add(WorkItemModel.fromWorkItem(entity.trackedWorkItems[i]));
    }
    return TrackingPeriodModel(
        id: entity.id,
        title: entity.title,
        usedHourlyRateInEuro: entity.usedHourlyRateInEuro,
        trackedWorkItemModels: entityWorkItemsConverted);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> trackedWorkItemsDynamicMapList =
        trackedWorkItemModels.map((e) => e.toJson()).toList();

    return {
      'id': id,
      'title': title,
      'usedHourlyRateInEuro': usedHourlyRateInEuro,
      'trackedWorkItems': trackedWorkItemsDynamicMapList
    };
  }
}
