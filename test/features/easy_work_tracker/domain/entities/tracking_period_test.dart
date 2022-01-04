import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

void main() {
  late TrackingPeriod trackingPeriod90EurosTest1;
  late TrackingPeriod trackingPeriod111EurosTest2;

  setUp(() {
    trackingPeriod90EurosTest1 = const TrackingPeriod(
      title: 'test 1',
      usedHourlyRateInEuro: 90,
      trackedWorkItems: [
        WorkItem(
            description: 'test', epicDescription: 'test epic', trackedHours: 4),
        WorkItem(
            description: 'description',
            epicDescription: 'epicDescription',
            trackedHours: 7),
        WorkItem(
            description: 'description',
            epicDescription: 'epicDescription',
            trackedHours: 74)
      ],
    );

    trackingPeriod111EurosTest2 = const TrackingPeriod(
      title: 'test 2',
      usedHourlyRateInEuro: 111,
      trackedWorkItems: [
        WorkItem(
            description: 'test',
            epicDescription: 'test epic',
            trackedHours: 124),
        WorkItem(
            description: 'description',
            epicDescription: 'epicDescription',
            trackedHours: 67),
        WorkItem(
            description: 'description',
            epicDescription: 'epicDescription',
            trackedHours: 13)
      ],
    );
  });

  group('[TrackingPeriod]', () {
    test(
        'should add up all tracked items of test track period 1 and return correct sum of tracked hours',
        () async {
      // Arrange

      // Act
      int result = trackingPeriod90EurosTest1.totalTrackedHours;
      // Assert
      expect(result, 85);
    });

    test('should multiply the total tracked hours with the hourly rate',
        () async {
      // Arrange
      // Act
      int result = trackingPeriod90EurosTest1.totalInvoiceAmount;
      // Assert
      expect(result, 7650);
    });

    test(
        'should add up all tracked items of test track period 2 and return correct sum of tracked hours',
        () async {
      // Arrange
      // Act
      int result = trackingPeriod111EurosTest2.totalTrackedHours;
      // Assert
      expect(result, 204);
    });

    test(
        'should multipy the hourly rate and the total tracked hours of test period 2',
        () async {
      // Arrange
      // Act
      int result = trackingPeriod111EurosTest2.totalInvoiceAmount;
      // Assert
      expect(result, 22644);
    });
  });
}
