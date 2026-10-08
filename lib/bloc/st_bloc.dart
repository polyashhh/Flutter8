import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/validate_name.dart';

import 'st_event.dart';
import 'st_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final ValidateNameUseCase validateName;

  StudentBloc(this.validateName) : super(StudentInitial()) {
    on<OpenProfileEvent>((event, emit) {
      if (!validateName(event.name)) {
        emit(ErrorState('Введите имя'));
        return;
      }

      emit(
        NavigateToProfileState(
          event.name,
        ),
      );
    });
  }
}