import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/constants/constants.dart';
import 'package:franks_invoice_tool/core/errors/exception.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/datasources/easy_work_tracker_remote_data_source.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'easy_work_tracker_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late EasyWorkTrackerRemoteDataSourceImpl dataSourceImpl;

  final String jsonStringResponseTrackingPeriods = fixture('response_get_tracking_periods.json');
  final String jsonStringResponseSingleTrackingPeriod = fixture('response_single_tracking_period.json');

  const tWorkItem = WorkItem(
    id: 1,
    associatedTrackingPeriodId: 1,
    description: 'description',
    epicDescription: 'epicDescription',
    trackedHours: 123,
  );
  const tTrackingPeriod = TrackingPeriod(
    id: 1,
    title: 'title',
    usedHourlyRateInEuro: 123,
    trackedWorkItems: [],
  );

  final AllTrackingPeriodsModel tAllTrackingPeriodsModel = AllTrackingPeriodsModel.fromJson(
    jsonDecode(jsonStringResponseTrackingPeriods),
  );

  setUp(() {
    mockClient = MockClient();
    dataSourceImpl = EasyWorkTrackerRemoteDataSourceImpl(client: mockClient);
  });

  void stubMockClientGetSuccess() {
    when(mockClient.get(GET_TRACKING_PERIODS_URI))
        .thenAnswer((_) async => http.Response(jsonStringResponseTrackingPeriods, 200));
  }

  void stubMockClientGetBadRequest() {
    when(mockClient.get(GET_TRACKING_PERIODS_URI))
        .thenAnswer((realInvocation) async => http.Response('Something went wrong', 400));
  }

  void stubAddWorkItemSuccess() {
    when(mockClient.post(ADD_WORK_ITEM_URI, body: jsonEncode(WorkItemModel.fromWorkItem(tWorkItem).toJson())))
        .thenAnswer((realInvocation) async => http.Response(jsonStringResponseSingleTrackingPeriod, 200));
  }

  void stubAddTrackingPeriodSuccess() {
    when(mockClient.post(any, body: anyNamed('body')))
        .thenAnswer((realInvocation) async => http.Response(jsonStringResponseTrackingPeriods, 200));
  }

  group('[EasyWorkTrackerRemoteDataSource - getTrackingPeriods]', () {
    test('should perform a get request to the get tracking periods endpoint', () async {
      // Arrange
      stubMockClientGetSuccess();
      // Act
      await dataSourceImpl.getTrackingPeriods();
      // Assert
      verify(mockClient.get(GET_TRACKING_PERIODS_URI));
    });
    test('should return remote data when the servers answers status code is 200 success', () async {
      // Arrange

      stubMockClientGetSuccess();
      // Act
      final result = await dataSourceImpl.getTrackingPeriods();
      // Assert
      expect(result, tAllTrackingPeriodsModel);
    });

    test('should throw a ServerException when the statusCode is not 200', () async {
      // Arrange\
      stubMockClientGetBadRequest();
      // Act
      final call = dataSourceImpl.getTrackingPeriods;
      // Assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('[EasyWorkTrackerRemoteDataSource - addWorkItem]', () {
    test('should perform a http post request with the given work item on the add work item endpoint',
        () async {
      // Arrange
      stubAddWorkItemSuccess();
      // Act
      await dataSourceImpl.addWorkItem(tWorkItem);
      // Assert
      verify(mockClient.post(ADD_WORK_ITEM_URI, body: jsonEncode(WorkItemModel.fromWorkItem(tWorkItem))));
    });

    test('should return a TrackingPeriodModel when the response status code is 200', () async {
      // Arrange
      stubAddWorkItemSuccess();
      // Act
      final result = await dataSourceImpl.addWorkItem(tWorkItem);
      // Assert
      expect(result, TrackingPeriodModel.fromJson(jsonDecode(jsonStringResponseSingleTrackingPeriod)));
    });

    test('should throw a ServerException when the response status is not 200', () async {
      // Arrange
      when(mockClient.post(ADD_WORK_ITEM_URI, body: jsonEncode(WorkItemModel.fromWorkItem(tWorkItem))))
          .thenThrow(ServerException());
      // Act
      final call = dataSourceImpl.addWorkItem;
      // Assert
      expect(() => call(tWorkItem), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('[EasyWorkTrackerRemoteDataSource - addTrackingPeriod]', () {
    test('should perform a http post on the add tracking period endpoint', () async {
      // Arrange
      stubAddTrackingPeriodSuccess();
      // Act
      await dataSourceImpl.addTrackingPeriod(tTrackingPeriod);
      // Assert
      verify(mockClient.post(ADD_TRACKING_PERIOD_URI,
          body: jsonEncode(TrackingPeriodModel.fromTrackingPeriod(tTrackingPeriod))));
    });
    test('should return AllTrackingPeriods if the responses status code is 200', () async {
      // Arrange
      stubAddTrackingPeriodSuccess();
      // Act
      final result = await dataSourceImpl.addTrackingPeriod(tTrackingPeriod);
      // Assert
      expect(result, tAllTrackingPeriodsModel);
    });

    test('should throw ServerException when the responses status code is not 200', () async {
      // Arrange
      when(mockClient.post(any, body: anyNamed('body'))).thenThrow(ServerException());
      // Act
      final call = dataSourceImpl.addTrackingPeriod;
      // Assert
      expect(() => call(tTrackingPeriod), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
