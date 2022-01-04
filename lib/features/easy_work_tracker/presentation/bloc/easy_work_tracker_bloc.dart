import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'easy_work_tracker_event.dart';
part 'easy_work_tracker_state.dart';

class EasyWorkTrackerBloc extends Bloc<EasyWorkTrackerEvent, EasyWorkTrackerState> {
  EasyWorkTrackerBloc() : super(EasyWorkTrackerInitial()) {
    on<EasyWorkTrackerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
