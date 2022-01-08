import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/core/constants/constants.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/core/util/input_converter.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/add_work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/usecases/get_tracking_periods.dart';

part 'easy_work_tracker_event.dart';
part 'easy_work_tracker_state.dart';

class EasyWorkTrackerBloc extends Bloc<EasyWorkTrackerEvent, EasyWorkTrackerState> {
  final InputConverter inputConverter;
  final GetTrackingPeriods getTrackingPeriods;
  final AddWorkItem addWorkItem;
  final AddTrackingPeriod addTrackingPeriod;

  EasyWorkTrackerBloc(
      {required this.inputConverter,
      required this.getTrackingPeriods,
      required this.addWorkItem,
      required this.addTrackingPeriod})
      : super(Empty()) {
    on<GetTrackingPeriodsEvent>((event, emit) async {
      emit(Loading());
      final result = await getTrackingPeriods(NoParams());
      result.fold((failure) {
        emit(
          const Error(message: SERVER_FAILURE_MESSAGE),
        );
      }, (allTrackingPeriods) {
        emit(
          TrackingPeriodsLoaded(allTrackingPeriods: allTrackingPeriods),
        );
      });
    });
    on<AddTrackingPeriodEvent>((event, emit) async {
      final parsedResult = inputConverter.convertStringToUnsignedInt(event.inputUsedHourlyRate);
      await parsedResult.fold((failure) {
        emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }, (parsedInteger) async {
        emit(Loading());
        final result = await addTrackingPeriod(
          TrackingPeriodParams(
            trackingPeriod: TrackingPeriod(
              title: event.inputTitle,
              usedHourlyRateInEuro: parsedInteger,
              trackedWorkItems: const [],
            ),
          ),
        );
        result.fold((failure) {
          emit(const Error(message: SERVER_FAILURE_MESSAGE));
        }, (allTrackingPeriods) {
          emit(TrackingPeriodsLoaded(allTrackingPeriods: allTrackingPeriods));
        });
      });
    });
  }
}
