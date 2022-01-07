import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

class WorkItemModel extends WorkItem {
  const WorkItemModel(
      {required String description,
      required String epicDescription,
      required int trackedHours})
      : super(
            description: description,
            epicDescription: epicDescription,
            trackedHours: trackedHours);

  factory WorkItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return WorkItemModel(
        description: jsonMap['description'],
        epicDescription: jsonMap['epicDescription'],
        trackedHours: jsonMap['trackedHours']);
  }

  factory WorkItemModel.fromWorkItem(WorkItem workItem) {
    return WorkItemModel(
        description: workItem.description,
        epicDescription: workItem.epicDescription,
        trackedHours: workItem.trackedHours);
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'epicDescription': epicDescription,
      'trackedHours': trackedHours
    };
  }
}
