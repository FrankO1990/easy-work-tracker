import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/errors/exception.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/util/network_info.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/datasources/easy_work_tracker_remote_data_source.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/repositories/easy_work_tracker_repository_impl.dart';
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
      AllTrackingPeriodsModel.fromJson(
          jsonDecode(fixture('response_get_tracking_periods.json')));

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockEasyWorkTrackerRemoteDataSource();
    repository = EasyWorkTrackerRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  group('[EasyWorkTrackerRepositoryImpl - getTrackingPeriods]', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      //fully stub the called methods
      when(mockRemoteDataSource.getTrackingPeriods())
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      await repository.getTrackingPeriods();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('[EasyWorkTrackerRepositoryImpl - getTrackingPeriods - device online]',
      () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
    });
    test(
        'should return remote data when the call to the remote data source is successful',
        () async {
      // Arrange

      when(mockRemoteDataSource.getTrackingPeriods())
          .thenAnswer((realInvocation) async => tAllTrackingPeriodsModel);
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verify(mockRemoteDataSource.getTrackingPeriods());
      expect(result, Right(tAllTrackingPeriodsModel));
    });

    test(
        'should return a ServerFailure when the response from the API is not successful',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTrackingPeriods())
          .thenThrow(ServerException());
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verify(mockRemoteDataSource.getTrackingPeriods());
      expect(result, Left(ServerFailure()));
    });
  });

  group('[EasyWorkTrackerImpl - getTrackingPeriods - Device is offline]', () {
    test('should return a DeviceOfflineFailure when the device is offline',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false);
      // Act
      final result = await repository.getTrackingPeriods();
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
