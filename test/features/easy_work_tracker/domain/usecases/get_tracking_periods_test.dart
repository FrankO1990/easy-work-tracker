import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/repositories/easy_work_tracker_repository.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/get_tracking_periods.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tracking_periods_test.mocks.dart';

@GenerateMocks([EasyWorkTrackerRepository])
void main() {
  late MockEasyWorkTrackerRepository mockEasyWorkTrackerRepository;
  late GetTrackingPeriods usecase;

  setUp(() {
    mockEasyWorkTrackerRepository = MockEasyWorkTrackerRepository();
    usecase = GetTrackingPeriods(mockEasyWorkTrackerRepository);
  });

  group('[GetTrackingPeriods]', () {
    test('should forward the call the dependent repository', () async {
      // Arrange
      when(mockEasyWorkTrackerRepository.getTrackingPeriods()).thenAnswer(
          (realInvocation) async => Right(AllTrackingPeriods(
              trackingPeriods: List<TrackingPeriod>.empty())));
      // Act
      await usecase(NoParams());
      // Assert
      verify(mockEasyWorkTrackerRepository.getTrackingPeriods());
      verifyNoMoreInteractions(mockEasyWorkTrackerRepository);
    });
  });
}
