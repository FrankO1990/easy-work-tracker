import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  AllTrackingPeriodsModel tAllTrackingPeriodsModel = const AllTrackingPeriodsModel(trackingPeriodModels: [
    TrackingPeriodModel(
      id: 1,
      title: 'test 1',
      usedHourlyRateInEuro: 123,
      trackedWorkItemModels: [
        WorkItemModel(
            id: 1, associatedTrackingPeriodId: 1, description: 'test 1', epicDescription: 'test 1', trackedHours: 123),
        WorkItemModel(
            id: 2, associatedTrackingPeriodId: 1, description: 'test 2', epicDescription: 'test 2', trackedHours: 123),
        WorkItemModel(
            id: 3, associatedTrackingPeriodId: 1, description: 'test 3', epicDescription: 'test 3', trackedHours: 123)
      ],
    ),
    TrackingPeriodModel(
      id: 2,
      title: 'test 2',
      usedHourlyRateInEuro: 123,
      trackedWorkItemModels: [
        WorkItemModel(
            id: 4, associatedTrackingPeriodId: 2, description: 'test 1', epicDescription: 'test 1', trackedHours: 123),
        WorkItemModel(
            id: 5, associatedTrackingPeriodId: 2, description: 'test 2', epicDescription: 'test 2', trackedHours: 123),
        WorkItemModel(
            id: 6, associatedTrackingPeriodId: 2, description: 'test 3', epicDescription: 'test 3', trackedHours: 123)
      ],
    )
  ]);

  group('[AllTrackingPeriodsModel]', () {
    test('should return a subclass of AllTrackingPeriods', () async {
      // Arrange
      // Act
      // Assert
      expect(tAllTrackingPeriodsModel, isA<AllTrackingPeriods>());
    });
  });

  group('[AllTrackingPeriodsModel fromJson]', () {
    test('should return a valid AllTrackingPeriodsModel from a json map input', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('response_get_tracking_periods.json'));
      // Act
      final result = AllTrackingPeriodsModel.fromJson(jsonMap);
      // Assert
      expect(result, tAllTrackingPeriodsModel);
    });
  });

  group('[AllTrackingPeriodsModel toJson]', () {
    test('should return a matching json map', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('response_get_tracking_periods.json'));
      // Act
      final result = tAllTrackingPeriodsModel.toJson();
      // Assert
      expect(result, jsonMap);
    });
  });
}
