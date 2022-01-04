import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_work_item.dart';

import 'package:mockito/mockito.dart';

import 'get_tracking_periods_test.mocks.dart';

void main() {
  late MockEasyWorkTrackerRepository mockEasyWorkTrackerRepository;
  late AddWorkItem usecase;

  const tWorkItem = WorkItem(
      description: 'description',
      epicDescription: 'epicDescription',
      trackedHours: 123);
  const tTrackingPeriod = TrackingPeriod(
      title: 'title', usedHourlyRateInEuro: 123, trackedWorkItems: [tWorkItem]);

  setUp(() {
    mockEasyWorkTrackerRepository = MockEasyWorkTrackerRepository();
    usecase = AddWorkItem(mockEasyWorkTrackerRepository);
  });

  group('[AddWorkItem]', () {
    test('should forward the call to the dependent repository', () async {
      // Arrange
      when(mockEasyWorkTrackerRepository.addWorkItem(any))
          .thenAnswer((realInvocation) async => const Right(tTrackingPeriod));
      // Act
      await usecase(const Params(workItem: tWorkItem));
      // Assert
      verify(mockEasyWorkTrackerRepository.addWorkItem(tWorkItem));
      verifyNoMoreInteractions(mockEasyWorkTrackerRepository);
    });
  });
}
