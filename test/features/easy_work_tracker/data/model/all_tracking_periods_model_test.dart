import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  AllTrackingPeriodsModel tAllTrackingPeriodsModel =
      const AllTrackingPeriodsModel(trackingPeriodModels: [
    TrackingPeriodModel(
      title: 'test 1',
      usedHourlyRateInEuro: 123,
      trackedWorkItemModels: [
        WorkItemModel(
            description: 'test 1',
            epicDescription: 'test 1',
            trackedHours: 123),
        WorkItemModel(
            description: 'test 2',
            epicDescription: 'test 2',
            trackedHours: 123),
        WorkItemModel(
            description: 'test 3', epicDescription: 'test 3', trackedHours: 123)
      ],
    ),
    TrackingPeriodModel(
      title: 'test 2',
      usedHourlyRateInEuro: 123,
      trackedWorkItemModels: [
        WorkItemModel(
            description: 'test 1',
            epicDescription: 'test 1',
            trackedHours: 123),
        WorkItemModel(
            description: 'test 2',
            epicDescription: 'test 2',
            trackedHours: 123),
        WorkItemModel(
            description: 'test 3', epicDescription: 'test 3', trackedHours: 123)
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
    test('should return a valid AllTrackingPeriodsModel from a json map input',
        () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('response_get_tracking_periods.json'));
      // Act
      final result = AllTrackingPeriodsModel.fromJson(jsonMap);
      // Assert
      expect(result, tAllTrackingPeriodsModel);
    });
  });

  group('[AllTrackingPeriodsModel toJson]', () {
    test('should return a matching json map', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('response_get_tracking_periods.json'));
      // Act
      final result = tAllTrackingPeriodsModel.toJson();
      // Assert
      expect(result, jsonMap);
    });
  });
}
