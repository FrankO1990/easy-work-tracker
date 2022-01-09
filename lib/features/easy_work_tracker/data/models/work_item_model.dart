import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

class WorkItemModel extends WorkItem {
  const WorkItemModel(
      {required int id,
      required int associatedTrackingPeriodId,
      required String description,
      required String epicDescription,
      required int trackedHours})
      : super(
            id: id,
            associatedTrackingPeriodId: associatedTrackingPeriodId,
            description: description,
            epicDescription: epicDescription,
            trackedHours: trackedHours);

  factory WorkItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return WorkItemModel(
        id: jsonMap['id'],
        associatedTrackingPeriodId: jsonMap['associatedTrackingPeriodId'],
        description: jsonMap['description'],
        epicDescription: jsonMap['epicDescription'],
        trackedHours: jsonMap['trackedHours']);
  }

  factory WorkItemModel.fromWorkItem(WorkItem workItem) {
    return WorkItemModel(
        id: workItem.id,
        associatedTrackingPeriodId: workItem.associatedTrackingPeriodId,
        description: workItem.description,
        epicDescription: workItem.epicDescription,
        trackedHours: workItem.trackedHours);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'associatedTrackingPeriodId': associatedTrackingPeriodId,
      'description': description,
      'epicDescription': epicDescription,
      'trackedHours': trackedHours
    };
  }
}
