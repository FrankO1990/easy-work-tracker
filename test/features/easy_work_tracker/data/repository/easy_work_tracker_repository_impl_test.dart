import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/errors/exception.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/util/network_info.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/datasources/easy_work_tracker_remote_data_source.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/repositories/easy_work_tracker_repository_impl.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'easy_work_tracker_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, EasyWorkTrackerRemoteDataSource])
void main() {
  late EasyWorkTrackerRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockEasyWorkTrackerRemoteDataSource mockRemoteDataSource;

  AllTrackingPeriodsModel tAllTrackingPeriodsModel =
      AllTrackingPeriodsModel.fromJson(jsonDecode(fixture('response_get_tracking_periods.json')));

  TrackingPeriod tTrackingPeriod =
      const TrackingPeriod(id: 1, title: 'title', usedHourlyRateInEuro: 123, trackedWorkItems: []);

  TrackingPeriodModel tTrackingPeriodModel =
      TrackingPeriodModel.fromJson(jsonDecode(fixture('response_single_tracking_period.json')));

  const WorkItem tWorkItem = WorkItem(
      id: 1,
      associatedTrackingPeriodId: 1,
      description: 'description',
      epicDescription: 'epicDescription',
      trackedHours: 123);

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockEasyWorkTrackerRemoteDataSource();
    repository =
        EasyWorkTrackerRepositoryImpl(remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  void stubNetworkInfoOnline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });
  }

  group('[EasyWorkTrackerRepositoryImpl-getTrackingPeriods-connection check]', () {
    stubNetworkInfoOnline();
    test('should check if the device is online', () async {
      // Arrange

      //fully stub the called methods
      when(mockRemoteDataSource.getTrackingPeriods())
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      await repository.getTrackingPeriods();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - getTrackingPeriods - device online]', () {
    stubNetworkInfoOnline();
    test('should return remote data when the call to the remote data source is successful', () async {
      // Arrange

      when(mockRemoteDataSource.getTrackingPeriods())
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verify(mockRemoteDataSource.getTrackingPeriods());
      expect(result, Right(tAllTrackingPeriodsModel));
    });

    test('should return a ServerFailure when the response from the API is not successful', () async {
      // Arrange
      when(mockRemoteDataSource.getTrackingPeriods()).thenThrow(ServerException());
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verify(mockRemoteDataSource.getTrackingPeriods());
      expect(result, Left(ServerFailure()));
    });
  });

  group('[EasyWorkTrackerImpl - getTrackingPeriods - Device is offline]', () {
    test('should return a DeviceOfflineFailure when the device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - addWorkItem - connection check]', () {
    stubNetworkInfoOnline();

    test('should check if the device is connected to the internet', () async {
      // Arrange
      when(mockRemoteDataSource.addWorkItem(any)).thenAnswer((realInvocation) async => tTrackingPeriodModel);
      // Act
      await repository.addWorkItem(tWorkItem);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - addWorkItem - Online Path]', () {
    stubNetworkInfoOnline();
    test('should return remote data when the call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.addWorkItem(any)).thenAnswer((realInvocation) async => tTrackingPeriodModel);
      const workItem = tWorkItem;
      // Act
      final result = await repository.addWorkItem(workItem);
      // Assert
      expect(result, Right(tTrackingPeriodModel));
      verify(mockRemoteDataSource.addWorkItem(workItem));
    });

    test('should return ServerFailure when the call is not successful', () async {
      // Arrange
      when(mockRemoteDataSource.addWorkItem(any)).thenThrow(ServerException());
      // Act
      final result = await repository.addWorkItem(tWorkItem);
      // Assert
      expect(result, Left(ServerFailure()));
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - addWorkItem - Offline Path]', () {
    test('should return a DeviceOfflineFailure when the device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      // Act
      final result = await repository.addWorkItem(tWorkItem);
      // Assert
      expect(result, Left(DeviceOfflineFailure()));
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - addTrackingPeriod-connection check]', () {
    stubNetworkInfoOnline();
    test('should check if the device is online', () async {
      // Arrange
      when(mockRemoteDataSource.addTrackingPeriod(any))
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      await repository.addTrackingPeriod(tTrackingPeriodModel);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('[EasyWorkTrackerRepositoryImpl-addTrackingPeriod-Online Path]', () {
    stubNetworkInfoOnline();
    test('should return remote data when the call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.addTrackingPeriod(any))
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      final result = await repository.addTrackingPeriod(tTrackingPeriod);
      // Assert
      expect(result, Right(tAllTrackingPeriodsModel));
      verify(mockRemoteDataSource.addTrackingPeriod(tTrackingPeriod));
    });

    test('should return ServerFailure when the call is not successful', () async {
      // Arrange
      when(mockRemoteDataSource.addTrackingPeriod(any)).thenThrow(ServerException());
      // Act
      final result = await repository.addTrackingPeriod(tTrackingPeriod);
      // Assert
      expect(result, Left(ServerFailure()));
    });
  });

  group('[EasyWorkTrackerRepositoryImpl-addTrackingPeriod-Offline Path]', () {
    test('should return DeviceOfflineFailure when the device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      // Act
      final result = await repository.addTrackingPeriod(tTrackingPeriod);
      // Assert
      expect(result, Left(DeviceOfflineFailure()));
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });
}
