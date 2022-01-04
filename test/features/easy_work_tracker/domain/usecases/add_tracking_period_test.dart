import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_tracking_period.dart';
import 'package:mockito/mockito.dart';

import 'get_tracking_periods_test.mocks.dart';

void main() {
  late MockEasyWorkTrackerRepository mockEasyWorkTrackerRepository;
  late AddTrackingPeriod usecase;

  setUp(() {
    mockEasyWorkTrackerRepository = MockEasyWorkTrackerRepository();
    usecase = AddTrackingPeriod(mockEasyWorkTrackerRepository);
  });

  group('[AddTrackingPeriod]', () {
    test('should forward the call to the dependent repository', () async {
      // Arrange
      when(mockEasyWorkTrackerRepository.addTrackingPeriod(any)).thenAnswer(
          (realInvocation) async => Right(AllTrackingPeriods(
              trackingPeriods: List<TrackingPeriod>.empty())));

      const trackingPeriod = TrackingPeriod(
          title: 'title', usedHourlyRateInEuro: 123, trackedWorkItems: []);
      // Act
      await usecase(const Params(trackingPeriod: trackingPeriod));
      // Assert
      verify(mockEasyWorkTrackerRepository.addTrackingPeriod(trackingPeriod));
      verifyNoMoreInteractions(mockEasyWorkTrackerRepository);
    });
  });
}
