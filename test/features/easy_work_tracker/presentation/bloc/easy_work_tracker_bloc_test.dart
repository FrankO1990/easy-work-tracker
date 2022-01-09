import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/constants/constants.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/core/util/input_converter.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/get_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/presentation/bloc/easy_work_tracker_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'easy_work_tracker_bloc_test.mocks.dart';

@GenerateMocks([InputConverter, GetTrackingPeriods, AddWorkItem, AddTrackingPeriod])
void main() {
  late EasyWorkTrackerBloc bloc;
  late MockInputConverter mockInputConverter;
  late MockGetTrackingPeriods mockGetTrackingPeriods;
  late MockAddWorkItem mockAddWorkItem;
  late MockAddTrackingPeriod mockAddTrackingPeriod;

  const tInputString = '123';
  final tInputIntegerParsed = int.parse(tInputString);

  final AllTrackingPeriods tAllTrackingPeriods = AllTrackingPeriodsModel.fromJson(
    jsonDecode(
      fixture('response_get_tracking_periods.json'),
    ),
  );

  final TrackingPeriod tTrackingPeriod = TrackingPeriod(
      id: 1, title: 'title', usedHourlyRateInEuro: tInputIntegerParsed, trackedWorkItems: const []);

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetTrackingPeriods = MockGetTrackingPeriods();
    mockAddWorkItem = MockAddWorkItem();
    mockAddTrackingPeriod = MockAddTrackingPeriod();

    bloc = EasyWorkTrackerBloc(
        getTrackingPeriods: mockGetTrackingPeriods,
        addWorkItem: mockAddWorkItem,
        addTrackingPeriod: mockAddTrackingPeriod,
        inputConverter: mockInputConverter);
  });

  void setUpMockInputConverterSuccess() {
    when(mockInputConverter.convertStringToUnsignedInt(any)).thenReturn(Right(tInputIntegerParsed));
  }

  test('[EasyWorkTrackerBloc - General] should emit Empty as the initial state', () async {
    // Arrange
    // Act
    // Assert
    expect(bloc.state, equals(Empty()));
  });

  group('[GetTrackingPeriodsEvent]', () {
    void setUpMockGetTrackingPeriodsCallSuccess() {
      when(mockGetTrackingPeriods(any)).thenAnswer((realInvocation) async => Right(tAllTrackingPeriods));
    }

    test('should get data from the getTrackingPeriods usecase', () async {
      // Arrange
      setUpMockGetTrackingPeriodsCallSuccess();
      // Act
      bloc.add(const GetTrackingPeriodsEvent());
      await untilCalled(mockGetTrackingPeriods(NoParams()));
      // Assert
      verify(mockGetTrackingPeriods(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is received successful', () async {
      // Arrange
      setUpMockGetTrackingPeriodsCallSuccess();
      // Assert later
      expectLater(bloc.stream,
          emitsInOrder([Loading(), TrackingPeriodsLoaded(allTrackingPeriods: tAllTrackingPeriods)]));
      // Act
      bloc.add(const GetTrackingPeriodsEvent());
      // Assert
    });

    test('should emit [Loading, Error] when the call fails', () async {
      // Arrange
      when(mockGetTrackingPeriods(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      // Assert later
      expectLater(bloc.stream, emitsInOrder([Loading(), const Error(message: SERVER_FAILURE_MESSAGE)]));
      // Act
      bloc.add(const GetTrackingPeriodsEvent());
    });
  });

  group('[AddTrackingPeriodEvent]', () {
    void setUpMockAddTrackingPeriodSuccess() {
      when(mockAddTrackingPeriod(any)).thenAnswer((realInvocation) async => Right(tAllTrackingPeriods));
    }

    test(
        'should call the InputConverter to validate and convert the input to an unsigned integer for used hourly rate',
        () async {
      // Arrange
      setUpMockInputConverterSuccess();
      setUpMockAddTrackingPeriodSuccess();
      // Act
      bloc.add(const AddTrackingPeriodEvent(inputTitle: 'title', inputUsedHourlyRate: tInputString));
      await untilCalled(mockInputConverter.convertStringToUnsignedInt(any));
      // Assert
      verify(mockInputConverter.convertStringToUnsignedInt(tInputString));
    });

    test('should emit [Error} when the input is invalid', () async {
      // Arrange
      when(mockInputConverter.convertStringToUnsignedInt(any)).thenReturn(Left(InvalidInputFailure()));
      // Assert later
      expectLater(bloc.stream, emitsInOrder([const Error(message: INVALID_INPUT_FAILURE_MESSAGE)]));
      // Act
      bloc.add(const AddTrackingPeriodEvent(inputTitle: 'inputTitle', inputUsedHourlyRate: tInputString));
    });

    test('should get response data from the AddTrackingPeriod usecase', () async {
      // Arrange
      setUpMockInputConverterSuccess();
      setUpMockAddTrackingPeriodSuccess();
      // Act
      bloc.add(const AddTrackingPeriodEvent(inputTitle: 'inputTitle', inputUsedHourlyRate: tInputString));
      await untilCalled(mockAddTrackingPeriod(any));
      // Assert
      verify(mockAddTrackingPeriod(TrackingPeriodParams(
          trackingPeriod: TrackingPeriod(
        id: 0,
        title: 'inputTitle',
        usedHourlyRateInEuro: tInputIntegerParsed,
        trackedWorkItems: const [],
      ))));
    });

    test('should emit [LoadingState, TrackingPeriodsLoaded] when data is received successful', () async {
      // Arrange
      setUpMockAddTrackingPeriodSuccess();
      setUpMockInputConverterSuccess();
      // assert later
      expectLater(bloc.stream,
          emitsInOrder([Loading(), TrackingPeriodsLoaded(allTrackingPeriods: tAllTrackingPeriods)]));
      // Assert
      bloc.add(const AddTrackingPeriodEvent(inputTitle: 'inputTitle', inputUsedHourlyRate: tInputString));
    });

    test('should emit [Loading, Error] when the call fails', () async {
      // Arrange
      setUpMockInputConverterSuccess();
      when(mockAddTrackingPeriod(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      // Assert later
      expectLater(bloc.stream, emitsInOrder([Loading(), const Error(message: SERVER_FAILURE_MESSAGE)]));
      // Assert
      bloc.add(const AddTrackingPeriodEvent(inputTitle: 'inputTitle', inputUsedHourlyRate: tInputString));
    });
  });
}
