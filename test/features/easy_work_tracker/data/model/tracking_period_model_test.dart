import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tTrackingPeriodModel = TrackingPeriodModel(
    title: 'test',
    usedHourlyRateInEuro: 123,
    trackedWorkItemModels: [
      WorkItemModel(
          description: 'test 1', epicDescription: 'test 1', trackedHours: 123),
      WorkItemModel(
          description: 'test 2', epicDescription: 'test 2', trackedHours: 123),
      WorkItemModel(
          description: 'test 3', epicDescription: 'test 3', trackedHours: 123)
    ],
  );

  group('[TrackingPeriodModel]', () {
    test('should return a subclass of TrackingPeriod', () async {
      // Arrange
      // Act
      // Assert
      expect(tTrackingPeriodModel, isA<TrackingPeriod>());
    });
  });

  group('[TrackingPeriodModel fromJson]', () {
    test('Should return a valid model from a json file input', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('response_single_tracking_period.json'));
      // Act
      final result = TrackingPeriodModel.fromJson(jsonMap);
      // Assert
      expect(result, tTrackingPeriodModel);
    });
  });

  group('[TrackingPeriodModel toJson]', () {
    test('should return a matching json map', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('response_single_tracking_period.json'));
      // Act
      final result = tTrackingPeriodModel.toJson();
      // Assert
      expect(result, jsonMap);
    });
  });
}
