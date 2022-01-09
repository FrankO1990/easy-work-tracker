import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  WorkItemModel tWorkItemModel = const WorkItemModel(
    id: 1,
    associatedTrackingPeriodId: 1,
    description: 'test',
    epicDescription: 'test',
    trackedHours: 123,
  );
  WorkItem tWorkItem = const WorkItem(
    id: 1,
    associatedTrackingPeriodId: 1,
    description: 'test',
    epicDescription: 'test',
    trackedHours: 123,
  );

  group('[WorkItemModel]', () {
    test('should return a subclass of WorkItem', () async {
      // Arrange
      // Act
      // Assert
      expect(tWorkItemModel, isA<WorkItem>());
    });
  });

  group('[WorkItemModel fromJson]', () {
    test('should return a valid WorkItemModel from an input json map', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('response_work_item.json'));
      // Act
      final result = WorkItemModel.fromJson(jsonMap);
      // Assert
      expect(result, tWorkItemModel);
    });
  });

  group('[WorkItemModel fromWorkItem]', () {
    test('should return a valid WorkItemModel from a WorkItem', () async {
      // Arrange

      // Act
      final result = WorkItemModel.fromWorkItem(tWorkItem);
      // Assert
      expect(result, tWorkItemModel);
    });
  });

  group('[WorkItemModel toJson]', () {
    test('should return a matching json map', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('response_work_item.json'));
      // Act
      final result = tWorkItemModel.toJson();
      // Assert
      expect(result, jsonMap);
    });
  });
}
